-- Unsigned 4-bit multiplier using gate arrays - deeply pipelined 13-stage 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_mul_4x4_dpl is
  Port (
    A, B         : in  STD_LOGIC_VECTOR(3 downto 0);
    start, clk   : in  STD_LOGIC;
    Y            : out STD_LOGIC_VECTOR(7 downto 0);
    Y_valid      : out STD_LOGIC
  );
  end array_mul_4x4_dpl;
  
architecture Structural of array_mul_4x4_dpl is
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
    
  type bit_matrix_1 is array (0 to 12, 3 downto 0) of STD_LOGIC;

  -- Registers
  signal A1: bit_matrix_1;
  signal B1: bit_matrix_1;
 
	signal PL_REG_0 : STD_LOGIC;
	signal PL_REG_1 : STD_LOGIC;
	signal PL_REG_2 : STD_LOGIC;
	signal PL_REG_3 : STD_LOGIC;
	signal PL_REG_4 : STD_LOGIC;
	signal PL_REG_5 : STD_LOGIC;
	signal PL_REG_6 : STD_LOGIC;
	signal PL_REG_7 : STD_LOGIC;
	signal PL_REG_8 : STD_LOGIC;
	signal PL_REG_9 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_10 : STD_LOGIC;
	signal PL_REG_11 : STD_LOGIC;
	signal PL_REG_12 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_13 : STD_LOGIC;
	signal PL_REG_14 : STD_LOGIC;
	signal PL_REG_15 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_16 : STD_LOGIC;
	signal PL_REG_17 : STD_LOGIC;
	signal PL_REG_18 : STD_LOGIC;
	signal PL_REG_19 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_20 : STD_LOGIC;
	signal PL_REG_21 : STD_LOGIC;
	signal PL_REG_22 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_23 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_24 : STD_LOGIC;
	signal PL_REG_25 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_26 : STD_LOGIC;
	signal PL_REG_27 : STD_LOGIC;
	signal PL_REG_28 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_29 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_30 : STD_LOGIC;
	signal PL_REG_31 : STD_LOGIC;

	signal Y0 : STD_LOGIC_VECTOR(11 downto 0);
	signal Y1 : STD_LOGIC_VECTOR(11 downto 0);
	signal Y2 : STD_LOGIC_VECTOR(9 downto 0);
	signal Y3 : STD_LOGIC_VECTOR(6 downto 0);
	signal Y4 : STD_LOGIC_VECTOR(3 downto 0);
	signal Y5 : STD_LOGIC_VECTOR(1 downto 0);
	signal Y6 : STD_LOGIC;
	signal Y7 : STD_LOGIC;

  signal valid : STD_LOGIC_VECTOR(13 downto 0) := (others => '0');

  -- Signals
  signal S: STD_LOGIC_VECTOR(11 downto 0);
  signal C: STD_LOGIC_VECTOR(11 downto 0);

begin
	-- stage 1
	HA0: half_adder port map(PL_REG_0, PL_REG_1, S(0), C(0));

	-- stage 2
	FA1: full_adder port map(PL_REG_2, PL_REG_3, PL_REG_4, S(1), C(1));

	-- stage 3
	HA2: half_adder port map(PL_REG_5, PL_REG_6, S(2), C(2));

	-- stage 4
	FA3: full_adder port map(PL_REG_7, PL_REG_8, PL_REG_9(1), S(3), C(3));

	-- stage 5
	FA4: full_adder port map(PL_REG_10, PL_REG_11, PL_REG_12(1), S(4), C(4));

	-- stage 6
	HA5: half_adder port map(PL_REG_13, PL_REG_14, S(5), C(5));

	-- stage 7
	HA6: half_adder port map(PL_REG_15(2), PL_REG_16, S(6), C(6));

	-- stage 8
	FA7: full_adder port map(PL_REG_17, PL_REG_18, PL_REG_19(2), S(7), C(7));

	-- stage 9
	FA8: full_adder port map(PL_REG_20, PL_REG_21, PL_REG_22(2), S(8), C(8));

	-- stage 10
	FA9: full_adder port map(PL_REG_23(2), PL_REG_24, PL_REG_25(1), S(9), C(9));

	-- stage 11
	FA10: full_adder port map(PL_REG_26, PL_REG_27, PL_REG_28(1), S(10), C(10));

	-- stage 12
	FA11: full_adder port map(PL_REG_29(1), PL_REG_30, PL_REG_31, S(11), C(11));

	-- stage 13

  process(clk)
  begin
    if rising_edge(clk) then
      if start = '1' then
        -- stage 0
        valid <= valid(12 downto 0) & '1';
        
        for i in 0 to 3 loop
          A1(0, i) <= A(i);
          B1(0, i) <= B(i);
        end loop;
      else
        valid <= valid(12 downto 0) & '0';
      end if;
      
      -- shift registers pipeline forward
      for i in 11 downto 0 loop
        for j in 0 to 3 loop 
          A1(i+1, j) <= A1(i, j);
          B1(i+1, j) <= B1(i, j);
        end loop;
      end loop;
    end if;
  end process;

  process(clk)
  begin
    if rising_edge(clk) then
		-- stage 1
		PL_REG_0 <= A1(0, 0) and B1(0, 1); -- Stage used in = 2
		PL_REG_1 <= A1(0, 1) and B1(0, 0); -- Stage used in = 2

		-- stage 2
		Y0 <= Y0(10 downto 0) & (A1(1, 0) and B1(1, 0));
		Y1 <= Y1(10 downto 0) & S(0);
		PL_REG_2 <= A1(1, 0) and B1(1, 2); -- Stage used in = 3
		PL_REG_3 <= A1(1, 1) and B1(1, 1); -- Stage used in = 3
		PL_REG_4 <= C(0); -- Stage used in = 3

		-- stage 3
		PL_REG_5 <= S(1); -- Stage used in = 4
		PL_REG_6 <= A1(2, 2) and B1(2, 0); -- Stage used in = 4
		PL_REG_9 <= PL_REG_9(0 downto 0) & C(1); -- Stage used in = 5

		-- stage 4
		Y2 <= Y2(8 downto 0) & S(2);
		PL_REG_7 <= A1(3, 0) and B1(3, 3); -- Stage used in = 5
		PL_REG_8 <= A1(3, 1) and B1(3, 2); -- Stage used in = 5
		PL_REG_12 <= PL_REG_12(0 downto 0) & C(2); -- Stage used in = 6

		-- stage 5
		PL_REG_10 <= S(3); -- Stage used in = 6
		PL_REG_11 <= A1(4, 2) and B1(4, 1); -- Stage used in = 6
		PL_REG_15 <= PL_REG_15(1 downto 0) & C(3); -- Stage used in = 8

		-- stage 6
		PL_REG_13 <= S(4); -- Stage used in = 7
		PL_REG_14 <= A1(5, 3) and B1(5, 0); -- Stage used in = 7
		PL_REG_19 <= PL_REG_19(1 downto 0) & C(4); -- Stage used in = 9

		-- stage 7
		Y3 <= Y3(5 downto 0) & S(5);
		PL_REG_16 <= A1(6, 1) and B1(6, 3); -- Stage used in = 8
		PL_REG_22 <= PL_REG_22(1 downto 0) & C(5); -- Stage used in = 10

		-- stage 8
		PL_REG_17 <= S(6); -- Stage used in = 9
		PL_REG_18 <= A1(7, 2) and B1(7, 2); -- Stage used in = 9
		PL_REG_23 <= PL_REG_23(1 downto 0) & C(6); -- Stage used in = 11

		-- stage 9
		PL_REG_20 <= S(7); -- Stage used in = 10
		PL_REG_21 <= A1(8, 3) and B1(8, 1); -- Stage used in = 10
		PL_REG_25 <= PL_REG_25(0 downto 0) & C(7); -- Stage used in = 11

		-- stage 10
		Y4 <= Y4(2 downto 0) & S(8);
		PL_REG_24 <= A1(9, 2) and B1(9, 3); -- Stage used in = 11
		PL_REG_28 <= PL_REG_28(0 downto 0) & C(8); -- Stage used in = 12

		-- stage 11
		PL_REG_26 <= S(9); -- Stage used in = 12
		PL_REG_27 <= A1(10, 3) and B1(10, 2); -- Stage used in = 12
		PL_REG_29 <= PL_REG_29(0 downto 0) & C(9); -- Stage used in = 13

		-- stage 12
		Y5 <= Y5(0 downto 0) & S(10);
		PL_REG_30 <= A1(11, 3) and B1(11, 3); -- Stage used in = 13
		PL_REG_31 <= C(10); -- Stage used in = 13

		-- stage 13
		Y6 <= S(11);
		Y7 <= C(11);

    end if;
  end process;
  
	Y(0) <= Y0(11);
	Y(1) <= Y1(11);
	Y(2) <= Y2(9);
	Y(3) <= Y3(6);
	Y(4) <= Y4(3);
	Y(5) <= Y5(1);
	Y(6) <= Y6;
	Y(7) <= Y7;

  Y_valid <= valid(13);  -- Asserted when output is valid
end Structural;
