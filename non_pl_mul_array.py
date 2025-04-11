# Generate VHDL code for n-bit array multiplier without pipelining
# Note this one only generates the main code snippet, not the whole file
import io
import sys
import argparse

def ha(component_num, a, b):
    return f"HA{component_num}: half_adder port map({a}, {b}, S({component_num}), C({component_num}));" 

def fa(component_num, a, b, cin):
    return f"FA{component_num}: full_adder port map({a}, {b}, {cin}, S({component_num}), C({component_num}));"

class parentSignal:
    def __init__(self, i):
        self.i = i

    def __repr__(self):
        return f"{self.__class__.__name__}({self.i})"

class A(parentSignal): pass
class B(parentSignal): pass
class C(parentSignal): pass
class S(parentSignal): pass
class Y(parentSignal): pass

class PP:
    def __init__(self, i, j):
        self.i = i
        self.j = j
    
    def __repr__(self):
        return f"PP({self.i},{self.j})"


def struct_code(bits_in=4):
    bits_out = bits_in*2
    COLS, ROWS = bits_out-2, bits_in-1

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
            self.in3 = "xxxxx"

        
        def __repr__(self):
            return (
                f"{self.type}_{str(self.num).zfill(2)}, " \
                f"{str(self.in1).zfill(2)}, {str(self.in2).zfill(2)}, {str(self.in3).zfill(2)}, " \
                f"({self.c}, {self.r})"
                )        

    array = [[Component(r, c) for c in range(COLS)] for r in range(ROWS)]
    component_num = 0
    final_carry = 0

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
                component.in3 = "xxxxx"
     
            component_num += 1

    total_components = component_num
    
    # Uncomment for debugging
    # for r in range(ROWS):
    #     for c in range(COLS-1, -1, -1):
    #         print(array[r][c], end="\t\t")
    #     print()

    buffer = io.StringIO() # Create a buffer
    sys.stdout = buffer # Redirect stdout

    stage = 0
    print(f"-- stage {stage}")
    print(f"{Y(0)} <= {A(0)} and {B(0)};\n")

    for c in range(COLS):
        if stage > 0:
            print(f"-- stage {stage}")

        for r in range(ROWS):
            component = array[r][c]
            if component.skipped:
                continue
            
            if isinstance(component.in1, PP):
                print(f"{component.in1} <= {A(component.in1.i)} and {B(component.in1.j)};")
            
            if isinstance(component.in2, PP):
                print(f"{component.in2} <= {A(component.in2.i)} and {B(component.in2.j)};")

            if component.is_ha:
                print(ha(component.num, component.in1, component.in2))
            else:
                print(fa(component.num, component.in1, component.in2, component.in3))
            
            out_component = component.num
        
        print(f"{Y(c+1)} <= {S(out_component)};")
        print()
        stage += 1

    final_carry = C(total_components-1)
    print(f"{Y(bits_out-1)} <= {final_carry};")

    sys.stdout = sys.__stdout__ # Reset stdout
    return buffer.getvalue() # Get printed content

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--bits", type=int, default=4, help="Number of input bits (bits >= 2)")
    args = parser.parse_args()

    print(struct_code(bits_in=args.bits))
