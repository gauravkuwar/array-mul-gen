def build_entity_code(
        bits_in, bits_out, pl_reg_def, y_pl_reg_def, struct_code, process_code, 
        y_reg_to_y_out_struct, num_stages, total_components
    ):

    template = \
f"""-- Unsigned {bits_in}-bit multiplier using gate arrays - deeply pipelined {num_stages}-stage 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_mul_{bits_in}x{bits_in}_dpl is
  Port (
    A, B         : in  STD_LOGIC_VECTOR({bits_in-1} downto 0);
    start, clk   : in  STD_LOGIC;
    Y            : out STD_LOGIC_VECTOR({bits_out-1} downto 0);
    Y_valid      : out STD_LOGIC
  );
  end array_mul_{bits_in}x{bits_in}_dpl;
  
architecture Structural of array_mul_{bits_in}x{bits_in}_dpl is
  Component half_adder
    Port (
      A     : in STD_LOGIC;
      B     : in STD_LOGIC;
      SUM   : out STD_LOGIC;
      COUT  : out STD_LOGIC
    );
  end component;

  Component full_adder
    Port (
      A     : in STD_LOGIC;
      B     : in STD_LOGIC;
      CIN   : in STD_LOGIC;
      SUM   : out STD_LOGIC;
      COUT  : out STD_LOGIC
    );
  end component;  
    
  type bit_matrix_1 is array (0 to {num_stages-1}, {bits_in-1} downto 0) of STD_LOGIC;

  -- Registers
  signal A1: bit_matrix_1;
  signal B1: bit_matrix_1;
 
{pl_reg_def}

{y_pl_reg_def}

  signal valid : STD_LOGIC_VECTOR({num_stages} downto 0) := (others => '0');

  -- Signals
  signal S: STD_LOGIC_VECTOR({total_components-1} downto 0);
  signal C: STD_LOGIC_VECTOR({total_components-1} downto 0);

begin
{struct_code}
  process(clk)
  begin
    if rising_edge(clk) then
      if start = '1' then
        -- stage 0
        valid <= valid({num_stages-1} downto 0) & '1';
        
        for i in 0 to {bits_in-1} loop
          A1(0, i) <= A(i);
          B1(0, i) <= B(i);
        end loop;
      else
        valid <= valid({num_stages-1} downto 0) & '0';
      end if;
      
      -- shift registers pipeline forward
      for i in {num_stages-2} downto 0 loop
        for j in 0 to {bits_in-1} loop 
          A1(i+1, j) <= A1(i, j);
          B1(i+1, j) <= B1(i, j);
        end loop;
      end loop;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
{process_code}
    end if;
  end process;
  
{y_reg_to_y_out_struct}

  Y_valid <= valid({num_stages});  -- Asserted when output is valid
end Structural;
"""
    return template
