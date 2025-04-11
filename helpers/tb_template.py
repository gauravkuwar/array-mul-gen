def build_tb_code(bits_in, bits_out, num_stages):
    template = \
f"""library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity array_mul_{bits_in}x{bits_in}_dpl_tb is
end array_mul_{bits_in}x{bits_in}_dpl_tb;

architecture sim of array_mul_{bits_in}x{bits_in}_dpl_tb is
  signal A, B   : STD_LOGIC_VECTOR({bits_in-1} downto 0);
  signal Y, Y_CORRECT : STD_LOGIC_VECTOR({bits_out-1} downto 0);
  signal Y_valid : STD_LOGIC;
  signal clk, start : STD_LOGIC;
  signal done_testing : STD_LOGIC := '0';

  constant clk_period : time := 10 ns; 
  constant n : integer := {(2**bits_in) - 1};
begin
  DUT: entity work.array_mul_{bits_in}x{bits_in}_dpl
    port map (
        A => A,
        B => B,
        start => start,
        clk => clk,
        Y => Y,
        Y_valid => Y_valid

    );

  -- Clock generation
  clk_process : process
  begin
    while done_testing = '0' loop
      clk <= '1'; wait for clk_period / 2;
      clk <= '0'; wait for clk_period / 2;
    end loop;
    wait;
  end process;  

  -- compute
  process
    variable i, j : integer;
    begin
    wait for clk_period;
    for i in 0 to n loop
        for j in 0 to n loop
          start <= '1';
          A <= std_logic_vector(to_unsigned(i, {bits_in}));
          B <= std_logic_vector(to_unsigned(j, {bits_in}));
          wait for clk_period;
          start <= '0';
        end loop;
    end loop;
    wait;
  end process;
  
  -- verify
  process
    variable i, j : integer;
    variable failed : boolean := false;
    begin
    wait for clk_period * {num_stages} + (clk_period / 2);
    wait until Y_valid = '1';
    for i in 0 to n loop
        for j in 0 to n loop
          Y_CORRECT <= std_logic_vector(to_unsigned(i * j, {bits_out}));
          wait until rising_edge(clk);

          if Y /= Y_CORRECT then
            report "FAIL: " & integer'image(i) & " * " & integer'image(j) &
                " = " & integer'image(to_integer(unsigned(Y))) &
                ", expected " & integer'image(to_integer(unsigned(Y_CORRECT)))
            severity error;
            failed := true;
          end if;
        end loop;
    end loop;
    done_testing <= '1';
    if not failed then
        report "All combinations passed!" severity note;
    end if;
    wait;
  end process;
end sim;
"""
    return template
