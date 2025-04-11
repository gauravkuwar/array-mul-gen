-- Unsigned 8-bit multiplier using gate arrays - deeply pipelined 57-stage 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_mul_8x8_dpl is
  Port (
    A, B         : in  STD_LOGIC_VECTOR(7 downto 0);
    start, clk   : in  STD_LOGIC;
    Y            : out STD_LOGIC_VECTOR(15 downto 0);
    Y_valid      : out STD_LOGIC
  );
  end array_mul_8x8_dpl;
  
architecture Structural of array_mul_8x8_dpl is
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
    
  type bit_matrix_1 is array (0 to 56, 7 downto 0) of STD_LOGIC;

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
	signal PL_REG_15 : STD_LOGIC;
	signal PL_REG_16 : STD_LOGIC;
	signal PL_REG_17 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_18 : STD_LOGIC;
	signal PL_REG_19 : STD_LOGIC;
	signal PL_REG_20 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_21 : STD_LOGIC;
	signal PL_REG_22 : STD_LOGIC;
	signal PL_REG_23 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_24 : STD_LOGIC;
	signal PL_REG_25 : STD_LOGIC;
	signal PL_REG_26 : STD_LOGIC;
	signal PL_REG_27 : STD_LOGIC;
	signal PL_REG_28 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_29 : STD_LOGIC;
	signal PL_REG_30 : STD_LOGIC;
	signal PL_REG_31 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_32 : STD_LOGIC;
	signal PL_REG_33 : STD_LOGIC;
	signal PL_REG_34 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_35 : STD_LOGIC;
	signal PL_REG_36 : STD_LOGIC;
	signal PL_REG_37 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_38 : STD_LOGIC;
	signal PL_REG_39 : STD_LOGIC;
	signal PL_REG_40 : STD_LOGIC;
	signal PL_REG_41 : STD_LOGIC;
	signal PL_REG_42 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_43 : STD_LOGIC;
	signal PL_REG_44 : STD_LOGIC;
	signal PL_REG_45 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_46 : STD_LOGIC;
	signal PL_REG_47 : STD_LOGIC;
	signal PL_REG_48 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_49 : STD_LOGIC;
	signal PL_REG_50 : STD_LOGIC;
	signal PL_REG_51 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_52 : STD_LOGIC;
	signal PL_REG_53 : STD_LOGIC;
	signal PL_REG_54 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_55 : STD_LOGIC;
	signal PL_REG_56 : STD_LOGIC;
	signal PL_REG_57 : STD_LOGIC;
	signal PL_REG_58 : STD_LOGIC;
	signal PL_REG_59 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_60 : STD_LOGIC;
	signal PL_REG_61 : STD_LOGIC;
	signal PL_REG_62 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_63 : STD_LOGIC;
	signal PL_REG_64 : STD_LOGIC;
	signal PL_REG_65 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_66 : STD_LOGIC;
	signal PL_REG_67 : STD_LOGIC;
	signal PL_REG_68 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_69 : STD_LOGIC;
	signal PL_REG_70 : STD_LOGIC;
	signal PL_REG_71 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_72 : STD_LOGIC;
	signal PL_REG_73 : STD_LOGIC;
	signal PL_REG_74 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_75 : STD_LOGIC;
	signal PL_REG_76 : STD_LOGIC;
	signal PL_REG_77 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_78 : STD_LOGIC;
	signal PL_REG_79 : STD_LOGIC;
	signal PL_REG_80 : STD_LOGIC;
	signal PL_REG_81 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_82 : STD_LOGIC;
	signal PL_REG_83 : STD_LOGIC;
	signal PL_REG_84 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_85 : STD_LOGIC;
	signal PL_REG_86 : STD_LOGIC;
	signal PL_REG_87 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_88 : STD_LOGIC;
	signal PL_REG_89 : STD_LOGIC;
	signal PL_REG_90 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_91 : STD_LOGIC;
	signal PL_REG_92 : STD_LOGIC;
	signal PL_REG_93 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_94 : STD_LOGIC;
	signal PL_REG_95 : STD_LOGIC;
	signal PL_REG_96 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_97 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_98 : STD_LOGIC;
	signal PL_REG_99 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_100 : STD_LOGIC;
	signal PL_REG_101 : STD_LOGIC;
	signal PL_REG_102 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_103 : STD_LOGIC;
	signal PL_REG_104 : STD_LOGIC;
	signal PL_REG_105 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_106 : STD_LOGIC;
	signal PL_REG_107 : STD_LOGIC;
	signal PL_REG_108 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_109 : STD_LOGIC;
	signal PL_REG_110 : STD_LOGIC;
	signal PL_REG_111 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_112 : STD_LOGIC;
	signal PL_REG_113 : STD_LOGIC;
	signal PL_REG_114 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_115 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_116 : STD_LOGIC;
	signal PL_REG_117 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_118 : STD_LOGIC;
	signal PL_REG_119 : STD_LOGIC;
	signal PL_REG_120 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_121 : STD_LOGIC;
	signal PL_REG_122 : STD_LOGIC;
	signal PL_REG_123 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_124 : STD_LOGIC;
	signal PL_REG_125 : STD_LOGIC;
	signal PL_REG_126 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_127 : STD_LOGIC;
	signal PL_REG_128 : STD_LOGIC;
	signal PL_REG_129 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_130 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_131 : STD_LOGIC;
	signal PL_REG_132 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_133 : STD_LOGIC;
	signal PL_REG_134 : STD_LOGIC;
	signal PL_REG_135 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_136 : STD_LOGIC;
	signal PL_REG_137 : STD_LOGIC;
	signal PL_REG_138 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_139 : STD_LOGIC;
	signal PL_REG_140 : STD_LOGIC;
	signal PL_REG_141 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_142 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_143 : STD_LOGIC;
	signal PL_REG_144 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_145 : STD_LOGIC;
	signal PL_REG_146 : STD_LOGIC;
	signal PL_REG_147 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_148 : STD_LOGIC;
	signal PL_REG_149 : STD_LOGIC;
	signal PL_REG_150 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_151 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_152 : STD_LOGIC;
	signal PL_REG_153 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_154 : STD_LOGIC;
	signal PL_REG_155 : STD_LOGIC;
	signal PL_REG_156 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_157 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_158 : STD_LOGIC;
	signal PL_REG_159 : STD_LOGIC;

	signal Y0 : STD_LOGIC_VECTOR(55 downto 0);
	signal Y1 : STD_LOGIC_VECTOR(55 downto 0);
	signal Y2 : STD_LOGIC_VECTOR(53 downto 0);
	signal Y3 : STD_LOGIC_VECTOR(50 downto 0);
	signal Y4 : STD_LOGIC_VECTOR(46 downto 0);
	signal Y5 : STD_LOGIC_VECTOR(41 downto 0);
	signal Y6 : STD_LOGIC_VECTOR(35 downto 0);
	signal Y7 : STD_LOGIC_VECTOR(28 downto 0);
	signal Y8 : STD_LOGIC_VECTOR(21 downto 0);
	signal Y9 : STD_LOGIC_VECTOR(15 downto 0);
	signal Y10 : STD_LOGIC_VECTOR(10 downto 0);
	signal Y11 : STD_LOGIC_VECTOR(6 downto 0);
	signal Y12 : STD_LOGIC_VECTOR(3 downto 0);
	signal Y13 : STD_LOGIC_VECTOR(1 downto 0);
	signal Y14 : STD_LOGIC;
	signal Y15 : STD_LOGIC;

  signal valid : STD_LOGIC_VECTOR(57 downto 0) := (others => '0');

  -- Signals
  signal S: STD_LOGIC_VECTOR(55 downto 0);
  signal C: STD_LOGIC_VECTOR(55 downto 0);

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
	FA6: full_adder port map(PL_REG_15, PL_REG_16, PL_REG_17(2), S(6), C(6));

	-- stage 8
	FA7: full_adder port map(PL_REG_18, PL_REG_19, PL_REG_20(2), S(7), C(7));

	-- stage 9
	FA8: full_adder port map(PL_REG_21, PL_REG_22, PL_REG_23(2), S(8), C(8));

	-- stage 10
	HA9: half_adder port map(PL_REG_24, PL_REG_25, S(9), C(9));

	-- stage 11
	FA10: full_adder port map(PL_REG_26, PL_REG_27, PL_REG_28(3), S(10), C(10));

	-- stage 12
	FA11: full_adder port map(PL_REG_29, PL_REG_30, PL_REG_31(3), S(11), C(11));

	-- stage 13
	FA12: full_adder port map(PL_REG_32, PL_REG_33, PL_REG_34(3), S(12), C(12));

	-- stage 14
	FA13: full_adder port map(PL_REG_35, PL_REG_36, PL_REG_37(3), S(13), C(13));

	-- stage 15
	HA14: half_adder port map(PL_REG_38, PL_REG_39, S(14), C(14));

	-- stage 16
	FA15: full_adder port map(PL_REG_40, PL_REG_41, PL_REG_42(4), S(15), C(15));

	-- stage 17
	FA16: full_adder port map(PL_REG_43, PL_REG_44, PL_REG_45(4), S(16), C(16));

	-- stage 18
	FA17: full_adder port map(PL_REG_46, PL_REG_47, PL_REG_48(4), S(17), C(17));

	-- stage 19
	FA18: full_adder port map(PL_REG_49, PL_REG_50, PL_REG_51(4), S(18), C(18));

	-- stage 20
	FA19: full_adder port map(PL_REG_52, PL_REG_53, PL_REG_54(4), S(19), C(19));

	-- stage 21
	HA20: half_adder port map(PL_REG_55, PL_REG_56, S(20), C(20));

	-- stage 22
	FA21: full_adder port map(PL_REG_57, PL_REG_58, PL_REG_59(5), S(21), C(21));

	-- stage 23
	FA22: full_adder port map(PL_REG_60, PL_REG_61, PL_REG_62(5), S(22), C(22));

	-- stage 24
	FA23: full_adder port map(PL_REG_63, PL_REG_64, PL_REG_65(5), S(23), C(23));

	-- stage 25
	FA24: full_adder port map(PL_REG_66, PL_REG_67, PL_REG_68(5), S(24), C(24));

	-- stage 26
	FA25: full_adder port map(PL_REG_69, PL_REG_70, PL_REG_71(5), S(25), C(25));

	-- stage 27
	FA26: full_adder port map(PL_REG_72, PL_REG_73, PL_REG_74(5), S(26), C(26));

	-- stage 28
	HA27: half_adder port map(PL_REG_75, PL_REG_76, S(27), C(27));

	-- stage 29
	HA28: half_adder port map(PL_REG_77(6), PL_REG_78, S(28), C(28));

	-- stage 30
	FA29: full_adder port map(PL_REG_79, PL_REG_80, PL_REG_81(6), S(29), C(29));

	-- stage 31
	FA30: full_adder port map(PL_REG_82, PL_REG_83, PL_REG_84(6), S(30), C(30));

	-- stage 32
	FA31: full_adder port map(PL_REG_85, PL_REG_86, PL_REG_87(6), S(31), C(31));

	-- stage 33
	FA32: full_adder port map(PL_REG_88, PL_REG_89, PL_REG_90(6), S(32), C(32));

	-- stage 34
	FA33: full_adder port map(PL_REG_91, PL_REG_92, PL_REG_93(6), S(33), C(33));

	-- stage 35
	FA34: full_adder port map(PL_REG_94, PL_REG_95, PL_REG_96(6), S(34), C(34));

	-- stage 36
	FA35: full_adder port map(PL_REG_97(6), PL_REG_98, PL_REG_99(5), S(35), C(35));

	-- stage 37
	FA36: full_adder port map(PL_REG_100, PL_REG_101, PL_REG_102(5), S(36), C(36));

	-- stage 38
	FA37: full_adder port map(PL_REG_103, PL_REG_104, PL_REG_105(5), S(37), C(37));

	-- stage 39
	FA38: full_adder port map(PL_REG_106, PL_REG_107, PL_REG_108(5), S(38), C(38));

	-- stage 40
	FA39: full_adder port map(PL_REG_109, PL_REG_110, PL_REG_111(5), S(39), C(39));

	-- stage 41
	FA40: full_adder port map(PL_REG_112, PL_REG_113, PL_REG_114(5), S(40), C(40));

	-- stage 42
	FA41: full_adder port map(PL_REG_115(5), PL_REG_116, PL_REG_117(4), S(41), C(41));

	-- stage 43
	FA42: full_adder port map(PL_REG_118, PL_REG_119, PL_REG_120(4), S(42), C(42));

	-- stage 44
	FA43: full_adder port map(PL_REG_121, PL_REG_122, PL_REG_123(4), S(43), C(43));

	-- stage 45
	FA44: full_adder port map(PL_REG_124, PL_REG_125, PL_REG_126(4), S(44), C(44));

	-- stage 46
	FA45: full_adder port map(PL_REG_127, PL_REG_128, PL_REG_129(4), S(45), C(45));

	-- stage 47
	FA46: full_adder port map(PL_REG_130(4), PL_REG_131, PL_REG_132(3), S(46), C(46));

	-- stage 48
	FA47: full_adder port map(PL_REG_133, PL_REG_134, PL_REG_135(3), S(47), C(47));

	-- stage 49
	FA48: full_adder port map(PL_REG_136, PL_REG_137, PL_REG_138(3), S(48), C(48));

	-- stage 50
	FA49: full_adder port map(PL_REG_139, PL_REG_140, PL_REG_141(3), S(49), C(49));

	-- stage 51
	FA50: full_adder port map(PL_REG_142(3), PL_REG_143, PL_REG_144(2), S(50), C(50));

	-- stage 52
	FA51: full_adder port map(PL_REG_145, PL_REG_146, PL_REG_147(2), S(51), C(51));

	-- stage 53
	FA52: full_adder port map(PL_REG_148, PL_REG_149, PL_REG_150(2), S(52), C(52));

	-- stage 54
	FA53: full_adder port map(PL_REG_151(2), PL_REG_152, PL_REG_153(1), S(53), C(53));

	-- stage 55
	FA54: full_adder port map(PL_REG_154, PL_REG_155, PL_REG_156(1), S(54), C(54));

	-- stage 56
	FA55: full_adder port map(PL_REG_157(1), PL_REG_158, PL_REG_159, S(55), C(55));

	-- stage 57

  process(clk)
  begin
    if rising_edge(clk) then
      if start = '1' then
        -- stage 0
        valid <= valid(56 downto 0) & '1';
        
        for i in 0 to 7 loop
          A1(0, i) <= A(i);
          B1(0, i) <= B(i);
        end loop;
      else
        valid <= valid(56 downto 0) & '0';
      end if;
      
      -- shift registers pipeline forward
      for i in 55 downto 0 loop
        for j in 0 to 7 loop 
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
		Y0 <= Y0(54 downto 0) & (A1(1, 0) and B1(1, 0));
		Y1 <= Y1(54 downto 0) & S(0);
		PL_REG_2 <= A1(1, 0) and B1(1, 2); -- Stage used in = 3
		PL_REG_3 <= A1(1, 1) and B1(1, 1); -- Stage used in = 3
		PL_REG_4 <= C(0); -- Stage used in = 3

		-- stage 3
		PL_REG_5 <= S(1); -- Stage used in = 4
		PL_REG_6 <= A1(2, 2) and B1(2, 0); -- Stage used in = 4
		PL_REG_9 <= PL_REG_9(0 downto 0) & C(1); -- Stage used in = 5

		-- stage 4
		Y2 <= Y2(52 downto 0) & S(2);
		PL_REG_7 <= A1(3, 0) and B1(3, 3); -- Stage used in = 5
		PL_REG_8 <= A1(3, 1) and B1(3, 2); -- Stage used in = 5
		PL_REG_12 <= PL_REG_12(0 downto 0) & C(2); -- Stage used in = 6

		-- stage 5
		PL_REG_10 <= S(3); -- Stage used in = 6
		PL_REG_11 <= A1(4, 2) and B1(4, 1); -- Stage used in = 6
		PL_REG_17 <= PL_REG_17(1 downto 0) & C(3); -- Stage used in = 8

		-- stage 6
		PL_REG_13 <= S(4); -- Stage used in = 7
		PL_REG_14 <= A1(5, 3) and B1(5, 0); -- Stage used in = 7
		PL_REG_20 <= PL_REG_20(1 downto 0) & C(4); -- Stage used in = 9

		-- stage 7
		Y3 <= Y3(49 downto 0) & S(5);
		PL_REG_15 <= A1(6, 0) and B1(6, 4); -- Stage used in = 8
		PL_REG_16 <= A1(6, 1) and B1(6, 3); -- Stage used in = 8
		PL_REG_23 <= PL_REG_23(1 downto 0) & C(5); -- Stage used in = 10

		-- stage 8
		PL_REG_18 <= S(6); -- Stage used in = 9
		PL_REG_19 <= A1(7, 2) and B1(7, 2); -- Stage used in = 9
		PL_REG_28 <= PL_REG_28(2 downto 0) & C(6); -- Stage used in = 12

		-- stage 9
		PL_REG_21 <= S(7); -- Stage used in = 10
		PL_REG_22 <= A1(8, 3) and B1(8, 1); -- Stage used in = 10
		PL_REG_31 <= PL_REG_31(2 downto 0) & C(7); -- Stage used in = 13

		-- stage 10
		PL_REG_24 <= S(8); -- Stage used in = 11
		PL_REG_25 <= A1(9, 4) and B1(9, 0); -- Stage used in = 11
		PL_REG_34 <= PL_REG_34(2 downto 0) & C(8); -- Stage used in = 14

		-- stage 11
		Y4 <= Y4(45 downto 0) & S(9);
		PL_REG_26 <= A1(10, 0) and B1(10, 5); -- Stage used in = 12
		PL_REG_27 <= A1(10, 1) and B1(10, 4); -- Stage used in = 12
		PL_REG_37 <= PL_REG_37(2 downto 0) & C(9); -- Stage used in = 15

		-- stage 12
		PL_REG_29 <= S(10); -- Stage used in = 13
		PL_REG_30 <= A1(11, 2) and B1(11, 3); -- Stage used in = 13
		PL_REG_42 <= PL_REG_42(3 downto 0) & C(10); -- Stage used in = 17

		-- stage 13
		PL_REG_32 <= S(11); -- Stage used in = 14
		PL_REG_33 <= A1(12, 3) and B1(12, 2); -- Stage used in = 14
		PL_REG_45 <= PL_REG_45(3 downto 0) & C(11); -- Stage used in = 18

		-- stage 14
		PL_REG_35 <= S(12); -- Stage used in = 15
		PL_REG_36 <= A1(13, 4) and B1(13, 1); -- Stage used in = 15
		PL_REG_48 <= PL_REG_48(3 downto 0) & C(12); -- Stage used in = 19

		-- stage 15
		PL_REG_38 <= S(13); -- Stage used in = 16
		PL_REG_39 <= A1(14, 5) and B1(14, 0); -- Stage used in = 16
		PL_REG_51 <= PL_REG_51(3 downto 0) & C(13); -- Stage used in = 20

		-- stage 16
		Y5 <= Y5(40 downto 0) & S(14);
		PL_REG_40 <= A1(15, 0) and B1(15, 6); -- Stage used in = 17
		PL_REG_41 <= A1(15, 1) and B1(15, 5); -- Stage used in = 17
		PL_REG_54 <= PL_REG_54(3 downto 0) & C(14); -- Stage used in = 21

		-- stage 17
		PL_REG_43 <= S(15); -- Stage used in = 18
		PL_REG_44 <= A1(16, 2) and B1(16, 4); -- Stage used in = 18
		PL_REG_59 <= PL_REG_59(4 downto 0) & C(15); -- Stage used in = 23

		-- stage 18
		PL_REG_46 <= S(16); -- Stage used in = 19
		PL_REG_47 <= A1(17, 3) and B1(17, 3); -- Stage used in = 19
		PL_REG_62 <= PL_REG_62(4 downto 0) & C(16); -- Stage used in = 24

		-- stage 19
		PL_REG_49 <= S(17); -- Stage used in = 20
		PL_REG_50 <= A1(18, 4) and B1(18, 2); -- Stage used in = 20
		PL_REG_65 <= PL_REG_65(4 downto 0) & C(17); -- Stage used in = 25

		-- stage 20
		PL_REG_52 <= S(18); -- Stage used in = 21
		PL_REG_53 <= A1(19, 5) and B1(19, 1); -- Stage used in = 21
		PL_REG_68 <= PL_REG_68(4 downto 0) & C(18); -- Stage used in = 26

		-- stage 21
		PL_REG_55 <= S(19); -- Stage used in = 22
		PL_REG_56 <= A1(20, 6) and B1(20, 0); -- Stage used in = 22
		PL_REG_71 <= PL_REG_71(4 downto 0) & C(19); -- Stage used in = 27

		-- stage 22
		Y6 <= Y6(34 downto 0) & S(20);
		PL_REG_57 <= A1(21, 0) and B1(21, 7); -- Stage used in = 23
		PL_REG_58 <= A1(21, 1) and B1(21, 6); -- Stage used in = 23
		PL_REG_74 <= PL_REG_74(4 downto 0) & C(20); -- Stage used in = 28

		-- stage 23
		PL_REG_60 <= S(21); -- Stage used in = 24
		PL_REG_61 <= A1(22, 2) and B1(22, 5); -- Stage used in = 24
		PL_REG_77 <= PL_REG_77(5 downto 0) & C(21); -- Stage used in = 30

		-- stage 24
		PL_REG_63 <= S(22); -- Stage used in = 25
		PL_REG_64 <= A1(23, 3) and B1(23, 4); -- Stage used in = 25
		PL_REG_81 <= PL_REG_81(5 downto 0) & C(22); -- Stage used in = 31

		-- stage 25
		PL_REG_66 <= S(23); -- Stage used in = 26
		PL_REG_67 <= A1(24, 4) and B1(24, 3); -- Stage used in = 26
		PL_REG_84 <= PL_REG_84(5 downto 0) & C(23); -- Stage used in = 32

		-- stage 26
		PL_REG_69 <= S(24); -- Stage used in = 27
		PL_REG_70 <= A1(25, 5) and B1(25, 2); -- Stage used in = 27
		PL_REG_87 <= PL_REG_87(5 downto 0) & C(24); -- Stage used in = 33

		-- stage 27
		PL_REG_72 <= S(25); -- Stage used in = 28
		PL_REG_73 <= A1(26, 6) and B1(26, 1); -- Stage used in = 28
		PL_REG_90 <= PL_REG_90(5 downto 0) & C(25); -- Stage used in = 34

		-- stage 28
		PL_REG_75 <= S(26); -- Stage used in = 29
		PL_REG_76 <= A1(27, 7) and B1(27, 0); -- Stage used in = 29
		PL_REG_93 <= PL_REG_93(5 downto 0) & C(26); -- Stage used in = 35

		-- stage 29
		Y7 <= Y7(27 downto 0) & S(27);
		PL_REG_78 <= A1(28, 1) and B1(28, 7); -- Stage used in = 30
		PL_REG_96 <= PL_REG_96(5 downto 0) & C(27); -- Stage used in = 36

		-- stage 30
		PL_REG_79 <= S(28); -- Stage used in = 31
		PL_REG_80 <= A1(29, 2) and B1(29, 6); -- Stage used in = 31
		PL_REG_97 <= PL_REG_97(5 downto 0) & C(28); -- Stage used in = 37

		-- stage 31
		PL_REG_82 <= S(29); -- Stage used in = 32
		PL_REG_83 <= A1(30, 3) and B1(30, 5); -- Stage used in = 32
		PL_REG_99 <= PL_REG_99(4 downto 0) & C(29); -- Stage used in = 37

		-- stage 32
		PL_REG_85 <= S(30); -- Stage used in = 33
		PL_REG_86 <= A1(31, 4) and B1(31, 4); -- Stage used in = 33
		PL_REG_102 <= PL_REG_102(4 downto 0) & C(30); -- Stage used in = 38

		-- stage 33
		PL_REG_88 <= S(31); -- Stage used in = 34
		PL_REG_89 <= A1(32, 5) and B1(32, 3); -- Stage used in = 34
		PL_REG_105 <= PL_REG_105(4 downto 0) & C(31); -- Stage used in = 39

		-- stage 34
		PL_REG_91 <= S(32); -- Stage used in = 35
		PL_REG_92 <= A1(33, 6) and B1(33, 2); -- Stage used in = 35
		PL_REG_108 <= PL_REG_108(4 downto 0) & C(32); -- Stage used in = 40

		-- stage 35
		PL_REG_94 <= S(33); -- Stage used in = 36
		PL_REG_95 <= A1(34, 7) and B1(34, 1); -- Stage used in = 36
		PL_REG_111 <= PL_REG_111(4 downto 0) & C(33); -- Stage used in = 41

		-- stage 36
		Y8 <= Y8(20 downto 0) & S(34);
		PL_REG_98 <= A1(35, 2) and B1(35, 7); -- Stage used in = 37
		PL_REG_114 <= PL_REG_114(4 downto 0) & C(34); -- Stage used in = 42

		-- stage 37
		PL_REG_100 <= S(35); -- Stage used in = 38
		PL_REG_101 <= A1(36, 3) and B1(36, 6); -- Stage used in = 38
		PL_REG_115 <= PL_REG_115(4 downto 0) & C(35); -- Stage used in = 43

		-- stage 38
		PL_REG_103 <= S(36); -- Stage used in = 39
		PL_REG_104 <= A1(37, 4) and B1(37, 5); -- Stage used in = 39
		PL_REG_117 <= PL_REG_117(3 downto 0) & C(36); -- Stage used in = 43

		-- stage 39
		PL_REG_106 <= S(37); -- Stage used in = 40
		PL_REG_107 <= A1(38, 5) and B1(38, 4); -- Stage used in = 40
		PL_REG_120 <= PL_REG_120(3 downto 0) & C(37); -- Stage used in = 44

		-- stage 40
		PL_REG_109 <= S(38); -- Stage used in = 41
		PL_REG_110 <= A1(39, 6) and B1(39, 3); -- Stage used in = 41
		PL_REG_123 <= PL_REG_123(3 downto 0) & C(38); -- Stage used in = 45

		-- stage 41
		PL_REG_112 <= S(39); -- Stage used in = 42
		PL_REG_113 <= A1(40, 7) and B1(40, 2); -- Stage used in = 42
		PL_REG_126 <= PL_REG_126(3 downto 0) & C(39); -- Stage used in = 46

		-- stage 42
		Y9 <= Y9(14 downto 0) & S(40);
		PL_REG_116 <= A1(41, 3) and B1(41, 7); -- Stage used in = 43
		PL_REG_129 <= PL_REG_129(3 downto 0) & C(40); -- Stage used in = 47

		-- stage 43
		PL_REG_118 <= S(41); -- Stage used in = 44
		PL_REG_119 <= A1(42, 4) and B1(42, 6); -- Stage used in = 44
		PL_REG_130 <= PL_REG_130(3 downto 0) & C(41); -- Stage used in = 48

		-- stage 44
		PL_REG_121 <= S(42); -- Stage used in = 45
		PL_REG_122 <= A1(43, 5) and B1(43, 5); -- Stage used in = 45
		PL_REG_132 <= PL_REG_132(2 downto 0) & C(42); -- Stage used in = 48

		-- stage 45
		PL_REG_124 <= S(43); -- Stage used in = 46
		PL_REG_125 <= A1(44, 6) and B1(44, 4); -- Stage used in = 46
		PL_REG_135 <= PL_REG_135(2 downto 0) & C(43); -- Stage used in = 49

		-- stage 46
		PL_REG_127 <= S(44); -- Stage used in = 47
		PL_REG_128 <= A1(45, 7) and B1(45, 3); -- Stage used in = 47
		PL_REG_138 <= PL_REG_138(2 downto 0) & C(44); -- Stage used in = 50

		-- stage 47
		Y10 <= Y10(9 downto 0) & S(45);
		PL_REG_131 <= A1(46, 4) and B1(46, 7); -- Stage used in = 48
		PL_REG_141 <= PL_REG_141(2 downto 0) & C(45); -- Stage used in = 51

		-- stage 48
		PL_REG_133 <= S(46); -- Stage used in = 49
		PL_REG_134 <= A1(47, 5) and B1(47, 6); -- Stage used in = 49
		PL_REG_142 <= PL_REG_142(2 downto 0) & C(46); -- Stage used in = 52

		-- stage 49
		PL_REG_136 <= S(47); -- Stage used in = 50
		PL_REG_137 <= A1(48, 6) and B1(48, 5); -- Stage used in = 50
		PL_REG_144 <= PL_REG_144(1 downto 0) & C(47); -- Stage used in = 52

		-- stage 50
		PL_REG_139 <= S(48); -- Stage used in = 51
		PL_REG_140 <= A1(49, 7) and B1(49, 4); -- Stage used in = 51
		PL_REG_147 <= PL_REG_147(1 downto 0) & C(48); -- Stage used in = 53

		-- stage 51
		Y11 <= Y11(5 downto 0) & S(49);
		PL_REG_143 <= A1(50, 5) and B1(50, 7); -- Stage used in = 52
		PL_REG_150 <= PL_REG_150(1 downto 0) & C(49); -- Stage used in = 54

		-- stage 52
		PL_REG_145 <= S(50); -- Stage used in = 53
		PL_REG_146 <= A1(51, 6) and B1(51, 6); -- Stage used in = 53
		PL_REG_151 <= PL_REG_151(1 downto 0) & C(50); -- Stage used in = 55

		-- stage 53
		PL_REG_148 <= S(51); -- Stage used in = 54
		PL_REG_149 <= A1(52, 7) and B1(52, 5); -- Stage used in = 54
		PL_REG_153 <= PL_REG_153(0 downto 0) & C(51); -- Stage used in = 55

		-- stage 54
		Y12 <= Y12(2 downto 0) & S(52);
		PL_REG_152 <= A1(53, 6) and B1(53, 7); -- Stage used in = 55
		PL_REG_156 <= PL_REG_156(0 downto 0) & C(52); -- Stage used in = 56

		-- stage 55
		PL_REG_154 <= S(53); -- Stage used in = 56
		PL_REG_155 <= A1(54, 7) and B1(54, 6); -- Stage used in = 56
		PL_REG_157 <= PL_REG_157(0 downto 0) & C(53); -- Stage used in = 57

		-- stage 56
		Y13 <= Y13(0 downto 0) & S(54);
		PL_REG_158 <= A1(55, 7) and B1(55, 7); -- Stage used in = 57
		PL_REG_159 <= C(54); -- Stage used in = 57

		-- stage 57
		Y14 <= S(55);
		Y15 <= C(55);

    end if;
  end process;
  
	Y(0) <= Y0(55);
	Y(1) <= Y1(55);
	Y(2) <= Y2(53);
	Y(3) <= Y3(50);
	Y(4) <= Y4(46);
	Y(5) <= Y5(41);
	Y(6) <= Y6(35);
	Y(7) <= Y7(28);
	Y(8) <= Y8(21);
	Y(9) <= Y9(15);
	Y(10) <= Y10(10);
	Y(11) <= Y11(6);
	Y(12) <= Y12(3);
	Y(13) <= Y13(1);
	Y(14) <= Y14;
	Y(15) <= Y15;

  Y_valid <= valid(57);  -- Asserted when output is valid
end Structural;
