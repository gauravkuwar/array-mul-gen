"""
Main generate VHDL code for n-bit array multiplier with deep pipelining
For n > 1
"""
import argparse

from helpers.misc import *
from helpers.entity_template import build_entity_code
from helpers.tb_template import build_tb_code

def main(bits_in=4, verbos=False, debug=False):
    bits_out = bits_in*2

    # ---------- Define Component Class ----------
    class Component:
        def __init__(self, r, c):
            self.r = r
            self.c = c

            self.skipped = (self.c < self.r) or (self.c - self.r) > (bits_in - 1)
            self.is_top_left_corner_ha = not self.skipped and (self.r == 0 and self.c == bits_in-1)
            self.is_ha = not self.skipped and (self.c == self.r or self.is_top_left_corner_ha)
            self.is_left_most_component = not self.skipped and ((self.c - self.r) == (bits_in - 1))

            if self.skipped:
                self.r = "x"
                self.c = "x"
                self.type = "xx"
            else:
                self.type = "HA" if self.is_ha else "FA"

            self.num = "xx"
            self.in1 = "xxxxx"
            self.in2 = "xxxxx"
            self.in3 = None

            self.is_out = False
            self.stage = None
        
        def __repr__(self):
            return (
                f"{self.type}_{str(self.num).zfill(2)}, " \
                f"{str(self.in1).zfill(2)}, {str(self.in2).zfill(2)}, {str(self.in3).zfill(2)}, " \
                f"({self.c}, {self.r})"
                )        

    # ---------- Build ha/fa matrix ----------
    COLS, ROWS = bits_out-2, bits_in-1
    array = [[Component(r, c) for c in range(COLS)] for r in range(ROWS)]
    component_num = 0

    for c in range(COLS):
        for r in range(ROWS):
            component = array[r][c]

            # skip the upper left and lower right of array
            if component.skipped:
                continue

            component.num = component_num
            component.in2 = PP(r+1, c-r)

            if r == 0:
                # Note: for top row we use top 2 rows of partial product
                component.in1 = PP(r, c+1)
            elif not component.is_left_most_component:
                component.in1 = S(component.num-1)

            if component.is_left_most_component:
                if r+1 < ROWS and c+1 < COLS:
                    array[r+1][c+1].in1 = C(component.num)
            else:
                if c+1 < COLS:
                    array[r][c+1].in3 = C(component.num)

            # top left corner half adder second input is a carry
            if component.is_top_left_corner_ha:
                component.in1 = component.in3
                component.in3 = None
     
            component_num += 1

    total_components = component_num

    # ---------- For Debugging ----------
    if debug:
        for r in range(ROWS):
            for c in range(COLS-1, -1, -1):
                print(array[r][c], end="\t\t")
            print()

    # ---------- Map component.num -> component ----------
    component_map = {}
    for c in range(COLS):
        for r in range(ROWS):
            component = array[r][c]
            if component.skipped:
                continue
            component_map[component.num] = component
            out_component = component
        component_map[out_component.num].is_out = True

    # ---------- Organize/Generate VHDL lines by grouped by pipeline stage ----------
    tot_stages = total_components + 1
    stages_struct = [[] for _ in range(tot_stages+1)] # struct code lines by stage
    stages_process = [[] for _ in range(tot_stages+1)] # process code lines by stage

    pl_reg_count = 0 # keep track fo pipeline register
    pl_reg_def = [] # pipeline register definitions
    y_pl_reg_def = [] # definitions of pipelined register for Y

    get_y_pl_depth = lambda s: tot_stages-s+1 # helper func
    y_reg_to_y_out_struct = [] # VHDL map of Y pipeline registers to Y output signal

    stage = 2

    # handle LSB
    stages_process[2] = [f"Y0 <= Y0({get_y_pl_depth(stage)-2} downto 0) & (A1(1, 0) and B1(1, 0));"]
    y_pl_reg_def.append(f"signal Y0 : STD_LOGIC_VECTOR({get_y_pl_depth(stage)-1} downto 0);")
    y_reg_to_y_out_struct.append(f"Y(0) <= Y0({get_y_pl_depth(stage)-1});")

    for num in range(total_components):
        component = component_map[num]

        # ---------- Clk Process Lines ----------
        if component.is_out:
            if component.c < bits_out-3:
                stages_process[stage].append(f"Y{component.c + 1} <= Y{component.c + 1}({get_y_pl_depth(stage)-2} downto 0) & {S(component.num)};")
                y_pl_reg_def.append(f"signal Y{component.c + 1} : STD_LOGIC_VECTOR({get_y_pl_depth(stage)-1} downto 0);")
                y_reg_to_y_out_struct.append(f"Y({component.c + 1}) <= Y{component.c + 1}({get_y_pl_depth(stage)-1});")
            else:
                stages_process[stage].append(f"Y{component.c + 1} <= {S(component.num)};")
                stages_process[stage].append(f"Y{component.c + 2} <= {C(component.num)};")
                y_pl_reg_def.append(f"signal Y{component.c + 1} : STD_LOGIC;")
                y_pl_reg_def.append(f"signal Y{component.c + 2} : STD_LOGIC;")
                y_reg_to_y_out_struct.append(f"Y({component.c + 1}) <= Y{component.c + 1};")
                y_reg_to_y_out_struct.append(f"Y({component.c + 2}) <= Y{component.c + 2};")

        new_pl_regs = {
            component.in1: None,
            component.in2: None,
            component.in3: None
        }
        
        for new_pl_reg in new_pl_regs:
            if not new_pl_reg: # if third input is None
                continue

            input_component = new_pl_reg

            if isinstance(input_component, PP):
                stage_created = stage - 1
                input_component = f"{A1(stage-2, input_component.i)} and {B1(stage-2, input_component.j)}"
            else:
                stage_created = input_component.i + 2

            stage_used = stage
            reg_size = stage_used - stage_created
            msb_place = reg_size - 1

            pl_reg_str = f"PL_REG_{pl_reg_count}"
            new_pl_regs[new_pl_reg] = f"{pl_reg_str}({msb_place})" if msb_place > 0 else pl_reg_str

            # shift only if pl reg size > 1 else we just replace
            if msb_place >= 1:
                stages_process[stage_created].append(f"{pl_reg_str} <= {pl_reg_str}({msb_place - 1} downto 0) & {input_component}; -- Stage used in = {stage_used}")
            else:
                stages_process[stage_created].append(f"{pl_reg_str} <= {input_component}; -- Stage used in = {stage_used}")

            if reg_size > 1:
                pl_reg_def.append(f"signal {pl_reg_str} : STD_LOGIC_VECTOR({reg_size-1} downto 0);")
            else:
                pl_reg_def.append(f"signal {pl_reg_str} : STD_LOGIC;")

            pl_reg_count += 1

        # ---------- Structural Lines ----------
        if component.is_ha:
            stages_struct[stage-1].append(ha(component.num, new_pl_regs[component.in1], new_pl_regs[component.in2], S(component.num), C(component.num)))
        else:
            stages_struct[stage-1].append(fa(component.num, new_pl_regs[component.in1], new_pl_regs[component.in2], new_pl_regs[component.in3], S(component.num), C(component.num)))

        stage += 1
    
    # ---------- Formatting lines ----------
    # build code string and add tabs
    struct_code = []
    process_code = []

    tabs = '\t' * 1
    for stage in range(1, len(stages_struct)):
        struct_code.append(f"{tabs}-- stage {stage}")
        for line in stages_struct[stage]:
            struct_code.append(f"{tabs}{line}")
        struct_code.append('')

    tabs = '\t' * 2
    for stage in range(1, len(stages_process)):
        process_code.append(f"{tabs}-- stage {stage}")
        for line in stages_process[stage]:
            process_code.append(f"{tabs}{line}")
        process_code.append('')

    add_tabs(pl_reg_def)
    add_tabs(y_pl_reg_def)
    add_tabs(y_reg_to_y_out_struct)

    if verbos:
        print(f"{bits_in} x {bits_in} => {bits_out}")
        print(f"Pipeline Stages = {tot_stages}")
        print(f"Pipeline Cycles = {tot_stages+1}")
        print(f"Total Components = {total_components}")

    # ---------- Combine into files and return ----------
    return (
        build_entity_code(
            bits_in=bits_in,
            bits_out=bits_out,
            pl_reg_def='\n'.join(pl_reg_def),
            y_pl_reg_def='\n'.join(y_pl_reg_def),
            struct_code='\n'.join(struct_code),
            process_code='\n'.join(process_code),
            y_reg_to_y_out_struct='\n'.join(y_reg_to_y_out_struct),
            num_stages=tot_stages,
            total_components=total_components
        ), 
        build_tb_code(
            bits_in=bits_in,
            bits_out=bits_out,
            num_stages=tot_stages
        )
    )

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--bits", type=int, default=4, help="Number of input bits (bits > 1)")
    args = parser.parse_args()

    bits_in = args.bits
    vhd_code, tb_code = main(bits_in=args.bits, verbos=True, debug=False)

    with open(f"generated_vhdl_code/array_mul_{bits_in}x{bits_in}_pl.vhd", "w") as f:
        f.write(vhd_code)
    with open(f"generated_vhdl_code/array_mul_{bits_in}x{bits_in}_pl_tb.vhd", "w") as f:
        f.write(tb_code)
