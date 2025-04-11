-- Unsigned 16-bit multiplier using gate arrays - deeply pipelined 241-stage 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_mul_16x16_dpl is
  Port (
    A, B         : in  STD_LOGIC_VECTOR(15 downto 0);
    start, clk   : in  STD_LOGIC;
    Y            : out STD_LOGIC_VECTOR(31 downto 0);
    Y_valid      : out STD_LOGIC
  );
  end array_mul_16x16_dpl;
  
architecture Structural of array_mul_16x16_dpl is
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
    
  type bit_matrix_1 is array (0 to 240, 15 downto 0) of STD_LOGIC;

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
	signal PL_REG_77 : STD_LOGIC;
	signal PL_REG_78 : STD_LOGIC;
	signal PL_REG_79 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_80 : STD_LOGIC;
	signal PL_REG_81 : STD_LOGIC;
	signal PL_REG_82 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_83 : STD_LOGIC;
	signal PL_REG_84 : STD_LOGIC;
	signal PL_REG_85 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_86 : STD_LOGIC;
	signal PL_REG_87 : STD_LOGIC;
	signal PL_REG_88 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_89 : STD_LOGIC;
	signal PL_REG_90 : STD_LOGIC;
	signal PL_REG_91 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_92 : STD_LOGIC;
	signal PL_REG_93 : STD_LOGIC;
	signal PL_REG_94 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_95 : STD_LOGIC;
	signal PL_REG_96 : STD_LOGIC;
	signal PL_REG_97 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_98 : STD_LOGIC;
	signal PL_REG_99 : STD_LOGIC;
	signal PL_REG_100 : STD_LOGIC;
	signal PL_REG_101 : STD_LOGIC;
	signal PL_REG_102 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_103 : STD_LOGIC;
	signal PL_REG_104 : STD_LOGIC;
	signal PL_REG_105 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_106 : STD_LOGIC;
	signal PL_REG_107 : STD_LOGIC;
	signal PL_REG_108 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_109 : STD_LOGIC;
	signal PL_REG_110 : STD_LOGIC;
	signal PL_REG_111 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_112 : STD_LOGIC;
	signal PL_REG_113 : STD_LOGIC;
	signal PL_REG_114 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_115 : STD_LOGIC;
	signal PL_REG_116 : STD_LOGIC;
	signal PL_REG_117 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_118 : STD_LOGIC;
	signal PL_REG_119 : STD_LOGIC;
	signal PL_REG_120 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_121 : STD_LOGIC;
	signal PL_REG_122 : STD_LOGIC;
	signal PL_REG_123 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_124 : STD_LOGIC;
	signal PL_REG_125 : STD_LOGIC;
	signal PL_REG_126 : STD_LOGIC;
	signal PL_REG_127 : STD_LOGIC;
	signal PL_REG_128 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_129 : STD_LOGIC;
	signal PL_REG_130 : STD_LOGIC;
	signal PL_REG_131 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_132 : STD_LOGIC;
	signal PL_REG_133 : STD_LOGIC;
	signal PL_REG_134 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_135 : STD_LOGIC;
	signal PL_REG_136 : STD_LOGIC;
	signal PL_REG_137 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_138 : STD_LOGIC;
	signal PL_REG_139 : STD_LOGIC;
	signal PL_REG_140 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_141 : STD_LOGIC;
	signal PL_REG_142 : STD_LOGIC;
	signal PL_REG_143 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_144 : STD_LOGIC;
	signal PL_REG_145 : STD_LOGIC;
	signal PL_REG_146 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_147 : STD_LOGIC;
	signal PL_REG_148 : STD_LOGIC;
	signal PL_REG_149 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_150 : STD_LOGIC;
	signal PL_REG_151 : STD_LOGIC;
	signal PL_REG_152 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_153 : STD_LOGIC;
	signal PL_REG_154 : STD_LOGIC;
	signal PL_REG_155 : STD_LOGIC;
	signal PL_REG_156 : STD_LOGIC;
	signal PL_REG_157 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_158 : STD_LOGIC;
	signal PL_REG_159 : STD_LOGIC;
	signal PL_REG_160 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_161 : STD_LOGIC;
	signal PL_REG_162 : STD_LOGIC;
	signal PL_REG_163 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_164 : STD_LOGIC;
	signal PL_REG_165 : STD_LOGIC;
	signal PL_REG_166 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_167 : STD_LOGIC;
	signal PL_REG_168 : STD_LOGIC;
	signal PL_REG_169 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_170 : STD_LOGIC;
	signal PL_REG_171 : STD_LOGIC;
	signal PL_REG_172 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_173 : STD_LOGIC;
	signal PL_REG_174 : STD_LOGIC;
	signal PL_REG_175 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_176 : STD_LOGIC;
	signal PL_REG_177 : STD_LOGIC;
	signal PL_REG_178 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_179 : STD_LOGIC;
	signal PL_REG_180 : STD_LOGIC;
	signal PL_REG_181 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_182 : STD_LOGIC;
	signal PL_REG_183 : STD_LOGIC;
	signal PL_REG_184 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_185 : STD_LOGIC;
	signal PL_REG_186 : STD_LOGIC;
	signal PL_REG_187 : STD_LOGIC;
	signal PL_REG_188 : STD_LOGIC;
	signal PL_REG_189 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_190 : STD_LOGIC;
	signal PL_REG_191 : STD_LOGIC;
	signal PL_REG_192 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_193 : STD_LOGIC;
	signal PL_REG_194 : STD_LOGIC;
	signal PL_REG_195 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_196 : STD_LOGIC;
	signal PL_REG_197 : STD_LOGIC;
	signal PL_REG_198 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_199 : STD_LOGIC;
	signal PL_REG_200 : STD_LOGIC;
	signal PL_REG_201 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_202 : STD_LOGIC;
	signal PL_REG_203 : STD_LOGIC;
	signal PL_REG_204 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_205 : STD_LOGIC;
	signal PL_REG_206 : STD_LOGIC;
	signal PL_REG_207 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_208 : STD_LOGIC;
	signal PL_REG_209 : STD_LOGIC;
	signal PL_REG_210 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_211 : STD_LOGIC;
	signal PL_REG_212 : STD_LOGIC;
	signal PL_REG_213 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_214 : STD_LOGIC;
	signal PL_REG_215 : STD_LOGIC;
	signal PL_REG_216 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_217 : STD_LOGIC;
	signal PL_REG_218 : STD_LOGIC;
	signal PL_REG_219 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_220 : STD_LOGIC;
	signal PL_REG_221 : STD_LOGIC;
	signal PL_REG_222 : STD_LOGIC;
	signal PL_REG_223 : STD_LOGIC;
	signal PL_REG_224 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_225 : STD_LOGIC;
	signal PL_REG_226 : STD_LOGIC;
	signal PL_REG_227 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_228 : STD_LOGIC;
	signal PL_REG_229 : STD_LOGIC;
	signal PL_REG_230 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_231 : STD_LOGIC;
	signal PL_REG_232 : STD_LOGIC;
	signal PL_REG_233 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_234 : STD_LOGIC;
	signal PL_REG_235 : STD_LOGIC;
	signal PL_REG_236 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_237 : STD_LOGIC;
	signal PL_REG_238 : STD_LOGIC;
	signal PL_REG_239 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_240 : STD_LOGIC;
	signal PL_REG_241 : STD_LOGIC;
	signal PL_REG_242 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_243 : STD_LOGIC;
	signal PL_REG_244 : STD_LOGIC;
	signal PL_REG_245 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_246 : STD_LOGIC;
	signal PL_REG_247 : STD_LOGIC;
	signal PL_REG_248 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_249 : STD_LOGIC;
	signal PL_REG_250 : STD_LOGIC;
	signal PL_REG_251 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_252 : STD_LOGIC;
	signal PL_REG_253 : STD_LOGIC;
	signal PL_REG_254 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_255 : STD_LOGIC;
	signal PL_REG_256 : STD_LOGIC;
	signal PL_REG_257 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_258 : STD_LOGIC;
	signal PL_REG_259 : STD_LOGIC;
	signal PL_REG_260 : STD_LOGIC;
	signal PL_REG_261 : STD_LOGIC;
	signal PL_REG_262 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_263 : STD_LOGIC;
	signal PL_REG_264 : STD_LOGIC;
	signal PL_REG_265 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_266 : STD_LOGIC;
	signal PL_REG_267 : STD_LOGIC;
	signal PL_REG_268 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_269 : STD_LOGIC;
	signal PL_REG_270 : STD_LOGIC;
	signal PL_REG_271 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_272 : STD_LOGIC;
	signal PL_REG_273 : STD_LOGIC;
	signal PL_REG_274 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_275 : STD_LOGIC;
	signal PL_REG_276 : STD_LOGIC;
	signal PL_REG_277 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_278 : STD_LOGIC;
	signal PL_REG_279 : STD_LOGIC;
	signal PL_REG_280 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_281 : STD_LOGIC;
	signal PL_REG_282 : STD_LOGIC;
	signal PL_REG_283 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_284 : STD_LOGIC;
	signal PL_REG_285 : STD_LOGIC;
	signal PL_REG_286 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_287 : STD_LOGIC;
	signal PL_REG_288 : STD_LOGIC;
	signal PL_REG_289 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_290 : STD_LOGIC;
	signal PL_REG_291 : STD_LOGIC;
	signal PL_REG_292 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_293 : STD_LOGIC;
	signal PL_REG_294 : STD_LOGIC;
	signal PL_REG_295 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_296 : STD_LOGIC;
	signal PL_REG_297 : STD_LOGIC;
	signal PL_REG_298 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_299 : STD_LOGIC;
	signal PL_REG_300 : STD_LOGIC;
	signal PL_REG_301 : STD_LOGIC;
	signal PL_REG_302 : STD_LOGIC;
	signal PL_REG_303 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_304 : STD_LOGIC;
	signal PL_REG_305 : STD_LOGIC;
	signal PL_REG_306 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_307 : STD_LOGIC;
	signal PL_REG_308 : STD_LOGIC;
	signal PL_REG_309 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_310 : STD_LOGIC;
	signal PL_REG_311 : STD_LOGIC;
	signal PL_REG_312 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_313 : STD_LOGIC;
	signal PL_REG_314 : STD_LOGIC;
	signal PL_REG_315 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_316 : STD_LOGIC;
	signal PL_REG_317 : STD_LOGIC;
	signal PL_REG_318 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_319 : STD_LOGIC;
	signal PL_REG_320 : STD_LOGIC;
	signal PL_REG_321 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_322 : STD_LOGIC;
	signal PL_REG_323 : STD_LOGIC;
	signal PL_REG_324 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_325 : STD_LOGIC;
	signal PL_REG_326 : STD_LOGIC;
	signal PL_REG_327 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_328 : STD_LOGIC;
	signal PL_REG_329 : STD_LOGIC;
	signal PL_REG_330 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_331 : STD_LOGIC;
	signal PL_REG_332 : STD_LOGIC;
	signal PL_REG_333 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_334 : STD_LOGIC;
	signal PL_REG_335 : STD_LOGIC;
	signal PL_REG_336 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_337 : STD_LOGIC;
	signal PL_REG_338 : STD_LOGIC;
	signal PL_REG_339 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_340 : STD_LOGIC;
	signal PL_REG_341 : STD_LOGIC;
	signal PL_REG_342 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_343 : STD_LOGIC;
	signal PL_REG_344 : STD_LOGIC;
	signal PL_REG_345 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_346 : STD_LOGIC;
	signal PL_REG_347 : STD_LOGIC;
	signal PL_REG_348 : STD_LOGIC;
	signal PL_REG_349 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_350 : STD_LOGIC;
	signal PL_REG_351 : STD_LOGIC;
	signal PL_REG_352 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_353 : STD_LOGIC;
	signal PL_REG_354 : STD_LOGIC;
	signal PL_REG_355 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_356 : STD_LOGIC;
	signal PL_REG_357 : STD_LOGIC;
	signal PL_REG_358 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_359 : STD_LOGIC;
	signal PL_REG_360 : STD_LOGIC;
	signal PL_REG_361 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_362 : STD_LOGIC;
	signal PL_REG_363 : STD_LOGIC;
	signal PL_REG_364 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_365 : STD_LOGIC;
	signal PL_REG_366 : STD_LOGIC;
	signal PL_REG_367 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_368 : STD_LOGIC;
	signal PL_REG_369 : STD_LOGIC;
	signal PL_REG_370 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_371 : STD_LOGIC;
	signal PL_REG_372 : STD_LOGIC;
	signal PL_REG_373 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_374 : STD_LOGIC;
	signal PL_REG_375 : STD_LOGIC;
	signal PL_REG_376 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_377 : STD_LOGIC;
	signal PL_REG_378 : STD_LOGIC;
	signal PL_REG_379 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_380 : STD_LOGIC;
	signal PL_REG_381 : STD_LOGIC;
	signal PL_REG_382 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_383 : STD_LOGIC;
	signal PL_REG_384 : STD_LOGIC;
	signal PL_REG_385 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_386 : STD_LOGIC;
	signal PL_REG_387 : STD_LOGIC;
	signal PL_REG_388 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_389 : STD_LOGIC_VECTOR(14 downto 0);
	signal PL_REG_390 : STD_LOGIC;
	signal PL_REG_391 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_392 : STD_LOGIC;
	signal PL_REG_393 : STD_LOGIC;
	signal PL_REG_394 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_395 : STD_LOGIC;
	signal PL_REG_396 : STD_LOGIC;
	signal PL_REG_397 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_398 : STD_LOGIC;
	signal PL_REG_399 : STD_LOGIC;
	signal PL_REG_400 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_401 : STD_LOGIC;
	signal PL_REG_402 : STD_LOGIC;
	signal PL_REG_403 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_404 : STD_LOGIC;
	signal PL_REG_405 : STD_LOGIC;
	signal PL_REG_406 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_407 : STD_LOGIC;
	signal PL_REG_408 : STD_LOGIC;
	signal PL_REG_409 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_410 : STD_LOGIC;
	signal PL_REG_411 : STD_LOGIC;
	signal PL_REG_412 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_413 : STD_LOGIC;
	signal PL_REG_414 : STD_LOGIC;
	signal PL_REG_415 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_416 : STD_LOGIC;
	signal PL_REG_417 : STD_LOGIC;
	signal PL_REG_418 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_419 : STD_LOGIC;
	signal PL_REG_420 : STD_LOGIC;
	signal PL_REG_421 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_422 : STD_LOGIC;
	signal PL_REG_423 : STD_LOGIC;
	signal PL_REG_424 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_425 : STD_LOGIC;
	signal PL_REG_426 : STD_LOGIC;
	signal PL_REG_427 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_428 : STD_LOGIC;
	signal PL_REG_429 : STD_LOGIC;
	signal PL_REG_430 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_431 : STD_LOGIC_VECTOR(13 downto 0);
	signal PL_REG_432 : STD_LOGIC;
	signal PL_REG_433 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_434 : STD_LOGIC;
	signal PL_REG_435 : STD_LOGIC;
	signal PL_REG_436 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_437 : STD_LOGIC;
	signal PL_REG_438 : STD_LOGIC;
	signal PL_REG_439 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_440 : STD_LOGIC;
	signal PL_REG_441 : STD_LOGIC;
	signal PL_REG_442 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_443 : STD_LOGIC;
	signal PL_REG_444 : STD_LOGIC;
	signal PL_REG_445 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_446 : STD_LOGIC;
	signal PL_REG_447 : STD_LOGIC;
	signal PL_REG_448 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_449 : STD_LOGIC;
	signal PL_REG_450 : STD_LOGIC;
	signal PL_REG_451 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_452 : STD_LOGIC;
	signal PL_REG_453 : STD_LOGIC;
	signal PL_REG_454 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_455 : STD_LOGIC;
	signal PL_REG_456 : STD_LOGIC;
	signal PL_REG_457 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_458 : STD_LOGIC;
	signal PL_REG_459 : STD_LOGIC;
	signal PL_REG_460 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_461 : STD_LOGIC;
	signal PL_REG_462 : STD_LOGIC;
	signal PL_REG_463 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_464 : STD_LOGIC;
	signal PL_REG_465 : STD_LOGIC;
	signal PL_REG_466 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_467 : STD_LOGIC;
	signal PL_REG_468 : STD_LOGIC;
	signal PL_REG_469 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_470 : STD_LOGIC_VECTOR(12 downto 0);
	signal PL_REG_471 : STD_LOGIC;
	signal PL_REG_472 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_473 : STD_LOGIC;
	signal PL_REG_474 : STD_LOGIC;
	signal PL_REG_475 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_476 : STD_LOGIC;
	signal PL_REG_477 : STD_LOGIC;
	signal PL_REG_478 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_479 : STD_LOGIC;
	signal PL_REG_480 : STD_LOGIC;
	signal PL_REG_481 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_482 : STD_LOGIC;
	signal PL_REG_483 : STD_LOGIC;
	signal PL_REG_484 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_485 : STD_LOGIC;
	signal PL_REG_486 : STD_LOGIC;
	signal PL_REG_487 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_488 : STD_LOGIC;
	signal PL_REG_489 : STD_LOGIC;
	signal PL_REG_490 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_491 : STD_LOGIC;
	signal PL_REG_492 : STD_LOGIC;
	signal PL_REG_493 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_494 : STD_LOGIC;
	signal PL_REG_495 : STD_LOGIC;
	signal PL_REG_496 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_497 : STD_LOGIC;
	signal PL_REG_498 : STD_LOGIC;
	signal PL_REG_499 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_500 : STD_LOGIC;
	signal PL_REG_501 : STD_LOGIC;
	signal PL_REG_502 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_503 : STD_LOGIC;
	signal PL_REG_504 : STD_LOGIC;
	signal PL_REG_505 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_506 : STD_LOGIC_VECTOR(11 downto 0);
	signal PL_REG_507 : STD_LOGIC;
	signal PL_REG_508 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_509 : STD_LOGIC;
	signal PL_REG_510 : STD_LOGIC;
	signal PL_REG_511 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_512 : STD_LOGIC;
	signal PL_REG_513 : STD_LOGIC;
	signal PL_REG_514 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_515 : STD_LOGIC;
	signal PL_REG_516 : STD_LOGIC;
	signal PL_REG_517 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_518 : STD_LOGIC;
	signal PL_REG_519 : STD_LOGIC;
	signal PL_REG_520 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_521 : STD_LOGIC;
	signal PL_REG_522 : STD_LOGIC;
	signal PL_REG_523 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_524 : STD_LOGIC;
	signal PL_REG_525 : STD_LOGIC;
	signal PL_REG_526 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_527 : STD_LOGIC;
	signal PL_REG_528 : STD_LOGIC;
	signal PL_REG_529 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_530 : STD_LOGIC;
	signal PL_REG_531 : STD_LOGIC;
	signal PL_REG_532 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_533 : STD_LOGIC;
	signal PL_REG_534 : STD_LOGIC;
	signal PL_REG_535 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_536 : STD_LOGIC;
	signal PL_REG_537 : STD_LOGIC;
	signal PL_REG_538 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_539 : STD_LOGIC_VECTOR(10 downto 0);
	signal PL_REG_540 : STD_LOGIC;
	signal PL_REG_541 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_542 : STD_LOGIC;
	signal PL_REG_543 : STD_LOGIC;
	signal PL_REG_544 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_545 : STD_LOGIC;
	signal PL_REG_546 : STD_LOGIC;
	signal PL_REG_547 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_548 : STD_LOGIC;
	signal PL_REG_549 : STD_LOGIC;
	signal PL_REG_550 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_551 : STD_LOGIC;
	signal PL_REG_552 : STD_LOGIC;
	signal PL_REG_553 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_554 : STD_LOGIC;
	signal PL_REG_555 : STD_LOGIC;
	signal PL_REG_556 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_557 : STD_LOGIC;
	signal PL_REG_558 : STD_LOGIC;
	signal PL_REG_559 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_560 : STD_LOGIC;
	signal PL_REG_561 : STD_LOGIC;
	signal PL_REG_562 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_563 : STD_LOGIC;
	signal PL_REG_564 : STD_LOGIC;
	signal PL_REG_565 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_566 : STD_LOGIC;
	signal PL_REG_567 : STD_LOGIC;
	signal PL_REG_568 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_569 : STD_LOGIC_VECTOR(9 downto 0);
	signal PL_REG_570 : STD_LOGIC;
	signal PL_REG_571 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_572 : STD_LOGIC;
	signal PL_REG_573 : STD_LOGIC;
	signal PL_REG_574 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_575 : STD_LOGIC;
	signal PL_REG_576 : STD_LOGIC;
	signal PL_REG_577 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_578 : STD_LOGIC;
	signal PL_REG_579 : STD_LOGIC;
	signal PL_REG_580 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_581 : STD_LOGIC;
	signal PL_REG_582 : STD_LOGIC;
	signal PL_REG_583 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_584 : STD_LOGIC;
	signal PL_REG_585 : STD_LOGIC;
	signal PL_REG_586 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_587 : STD_LOGIC;
	signal PL_REG_588 : STD_LOGIC;
	signal PL_REG_589 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_590 : STD_LOGIC;
	signal PL_REG_591 : STD_LOGIC;
	signal PL_REG_592 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_593 : STD_LOGIC;
	signal PL_REG_594 : STD_LOGIC;
	signal PL_REG_595 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_596 : STD_LOGIC_VECTOR(8 downto 0);
	signal PL_REG_597 : STD_LOGIC;
	signal PL_REG_598 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_599 : STD_LOGIC;
	signal PL_REG_600 : STD_LOGIC;
	signal PL_REG_601 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_602 : STD_LOGIC;
	signal PL_REG_603 : STD_LOGIC;
	signal PL_REG_604 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_605 : STD_LOGIC;
	signal PL_REG_606 : STD_LOGIC;
	signal PL_REG_607 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_608 : STD_LOGIC;
	signal PL_REG_609 : STD_LOGIC;
	signal PL_REG_610 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_611 : STD_LOGIC;
	signal PL_REG_612 : STD_LOGIC;
	signal PL_REG_613 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_614 : STD_LOGIC;
	signal PL_REG_615 : STD_LOGIC;
	signal PL_REG_616 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_617 : STD_LOGIC;
	signal PL_REG_618 : STD_LOGIC;
	signal PL_REG_619 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_620 : STD_LOGIC_VECTOR(7 downto 0);
	signal PL_REG_621 : STD_LOGIC;
	signal PL_REG_622 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_623 : STD_LOGIC;
	signal PL_REG_624 : STD_LOGIC;
	signal PL_REG_625 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_626 : STD_LOGIC;
	signal PL_REG_627 : STD_LOGIC;
	signal PL_REG_628 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_629 : STD_LOGIC;
	signal PL_REG_630 : STD_LOGIC;
	signal PL_REG_631 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_632 : STD_LOGIC;
	signal PL_REG_633 : STD_LOGIC;
	signal PL_REG_634 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_635 : STD_LOGIC;
	signal PL_REG_636 : STD_LOGIC;
	signal PL_REG_637 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_638 : STD_LOGIC;
	signal PL_REG_639 : STD_LOGIC;
	signal PL_REG_640 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_641 : STD_LOGIC_VECTOR(6 downto 0);
	signal PL_REG_642 : STD_LOGIC;
	signal PL_REG_643 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_644 : STD_LOGIC;
	signal PL_REG_645 : STD_LOGIC;
	signal PL_REG_646 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_647 : STD_LOGIC;
	signal PL_REG_648 : STD_LOGIC;
	signal PL_REG_649 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_650 : STD_LOGIC;
	signal PL_REG_651 : STD_LOGIC;
	signal PL_REG_652 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_653 : STD_LOGIC;
	signal PL_REG_654 : STD_LOGIC;
	signal PL_REG_655 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_656 : STD_LOGIC;
	signal PL_REG_657 : STD_LOGIC;
	signal PL_REG_658 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_659 : STD_LOGIC_VECTOR(5 downto 0);
	signal PL_REG_660 : STD_LOGIC;
	signal PL_REG_661 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_662 : STD_LOGIC;
	signal PL_REG_663 : STD_LOGIC;
	signal PL_REG_664 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_665 : STD_LOGIC;
	signal PL_REG_666 : STD_LOGIC;
	signal PL_REG_667 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_668 : STD_LOGIC;
	signal PL_REG_669 : STD_LOGIC;
	signal PL_REG_670 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_671 : STD_LOGIC;
	signal PL_REG_672 : STD_LOGIC;
	signal PL_REG_673 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_674 : STD_LOGIC_VECTOR(4 downto 0);
	signal PL_REG_675 : STD_LOGIC;
	signal PL_REG_676 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_677 : STD_LOGIC;
	signal PL_REG_678 : STD_LOGIC;
	signal PL_REG_679 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_680 : STD_LOGIC;
	signal PL_REG_681 : STD_LOGIC;
	signal PL_REG_682 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_683 : STD_LOGIC;
	signal PL_REG_684 : STD_LOGIC;
	signal PL_REG_685 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_686 : STD_LOGIC_VECTOR(3 downto 0);
	signal PL_REG_687 : STD_LOGIC;
	signal PL_REG_688 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_689 : STD_LOGIC;
	signal PL_REG_690 : STD_LOGIC;
	signal PL_REG_691 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_692 : STD_LOGIC;
	signal PL_REG_693 : STD_LOGIC;
	signal PL_REG_694 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_695 : STD_LOGIC_VECTOR(2 downto 0);
	signal PL_REG_696 : STD_LOGIC;
	signal PL_REG_697 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_698 : STD_LOGIC;
	signal PL_REG_699 : STD_LOGIC;
	signal PL_REG_700 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_701 : STD_LOGIC_VECTOR(1 downto 0);
	signal PL_REG_702 : STD_LOGIC;
	signal PL_REG_703 : STD_LOGIC;

	signal Y0 : STD_LOGIC_VECTOR(239 downto 0);
	signal Y1 : STD_LOGIC_VECTOR(239 downto 0);
	signal Y2 : STD_LOGIC_VECTOR(237 downto 0);
	signal Y3 : STD_LOGIC_VECTOR(234 downto 0);
	signal Y4 : STD_LOGIC_VECTOR(230 downto 0);
	signal Y5 : STD_LOGIC_VECTOR(225 downto 0);
	signal Y6 : STD_LOGIC_VECTOR(219 downto 0);
	signal Y7 : STD_LOGIC_VECTOR(212 downto 0);
	signal Y8 : STD_LOGIC_VECTOR(204 downto 0);
	signal Y9 : STD_LOGIC_VECTOR(195 downto 0);
	signal Y10 : STD_LOGIC_VECTOR(185 downto 0);
	signal Y11 : STD_LOGIC_VECTOR(174 downto 0);
	signal Y12 : STD_LOGIC_VECTOR(162 downto 0);
	signal Y13 : STD_LOGIC_VECTOR(149 downto 0);
	signal Y14 : STD_LOGIC_VECTOR(135 downto 0);
	signal Y15 : STD_LOGIC_VECTOR(120 downto 0);
	signal Y16 : STD_LOGIC_VECTOR(105 downto 0);
	signal Y17 : STD_LOGIC_VECTOR(91 downto 0);
	signal Y18 : STD_LOGIC_VECTOR(78 downto 0);
	signal Y19 : STD_LOGIC_VECTOR(66 downto 0);
	signal Y20 : STD_LOGIC_VECTOR(55 downto 0);
	signal Y21 : STD_LOGIC_VECTOR(45 downto 0);
	signal Y22 : STD_LOGIC_VECTOR(36 downto 0);
	signal Y23 : STD_LOGIC_VECTOR(28 downto 0);
	signal Y24 : STD_LOGIC_VECTOR(21 downto 0);
	signal Y25 : STD_LOGIC_VECTOR(15 downto 0);
	signal Y26 : STD_LOGIC_VECTOR(10 downto 0);
	signal Y27 : STD_LOGIC_VECTOR(6 downto 0);
	signal Y28 : STD_LOGIC_VECTOR(3 downto 0);
	signal Y29 : STD_LOGIC_VECTOR(1 downto 0);
	signal Y30 : STD_LOGIC;
	signal Y31 : STD_LOGIC;

  signal valid : STD_LOGIC_VECTOR(241 downto 0) := (others => '0');

  -- Signals
  signal S: STD_LOGIC_VECTOR(239 downto 0);
  signal C: STD_LOGIC_VECTOR(239 downto 0);

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
	FA28: full_adder port map(PL_REG_77, PL_REG_78, PL_REG_79(6), S(28), C(28));

	-- stage 30
	FA29: full_adder port map(PL_REG_80, PL_REG_81, PL_REG_82(6), S(29), C(29));

	-- stage 31
	FA30: full_adder port map(PL_REG_83, PL_REG_84, PL_REG_85(6), S(30), C(30));

	-- stage 32
	FA31: full_adder port map(PL_REG_86, PL_REG_87, PL_REG_88(6), S(31), C(31));

	-- stage 33
	FA32: full_adder port map(PL_REG_89, PL_REG_90, PL_REG_91(6), S(32), C(32));

	-- stage 34
	FA33: full_adder port map(PL_REG_92, PL_REG_93, PL_REG_94(6), S(33), C(33));

	-- stage 35
	FA34: full_adder port map(PL_REG_95, PL_REG_96, PL_REG_97(6), S(34), C(34));

	-- stage 36
	HA35: half_adder port map(PL_REG_98, PL_REG_99, S(35), C(35));

	-- stage 37
	FA36: full_adder port map(PL_REG_100, PL_REG_101, PL_REG_102(7), S(36), C(36));

	-- stage 38
	FA37: full_adder port map(PL_REG_103, PL_REG_104, PL_REG_105(7), S(37), C(37));

	-- stage 39
	FA38: full_adder port map(PL_REG_106, PL_REG_107, PL_REG_108(7), S(38), C(38));

	-- stage 40
	FA39: full_adder port map(PL_REG_109, PL_REG_110, PL_REG_111(7), S(39), C(39));

	-- stage 41
	FA40: full_adder port map(PL_REG_112, PL_REG_113, PL_REG_114(7), S(40), C(40));

	-- stage 42
	FA41: full_adder port map(PL_REG_115, PL_REG_116, PL_REG_117(7), S(41), C(41));

	-- stage 43
	FA42: full_adder port map(PL_REG_118, PL_REG_119, PL_REG_120(7), S(42), C(42));

	-- stage 44
	FA43: full_adder port map(PL_REG_121, PL_REG_122, PL_REG_123(7), S(43), C(43));

	-- stage 45
	HA44: half_adder port map(PL_REG_124, PL_REG_125, S(44), C(44));

	-- stage 46
	FA45: full_adder port map(PL_REG_126, PL_REG_127, PL_REG_128(8), S(45), C(45));

	-- stage 47
	FA46: full_adder port map(PL_REG_129, PL_REG_130, PL_REG_131(8), S(46), C(46));

	-- stage 48
	FA47: full_adder port map(PL_REG_132, PL_REG_133, PL_REG_134(8), S(47), C(47));

	-- stage 49
	FA48: full_adder port map(PL_REG_135, PL_REG_136, PL_REG_137(8), S(48), C(48));

	-- stage 50
	FA49: full_adder port map(PL_REG_138, PL_REG_139, PL_REG_140(8), S(49), C(49));

	-- stage 51
	FA50: full_adder port map(PL_REG_141, PL_REG_142, PL_REG_143(8), S(50), C(50));

	-- stage 52
	FA51: full_adder port map(PL_REG_144, PL_REG_145, PL_REG_146(8), S(51), C(51));

	-- stage 53
	FA52: full_adder port map(PL_REG_147, PL_REG_148, PL_REG_149(8), S(52), C(52));

	-- stage 54
	FA53: full_adder port map(PL_REG_150, PL_REG_151, PL_REG_152(8), S(53), C(53));

	-- stage 55
	HA54: half_adder port map(PL_REG_153, PL_REG_154, S(54), C(54));

	-- stage 56
	FA55: full_adder port map(PL_REG_155, PL_REG_156, PL_REG_157(9), S(55), C(55));

	-- stage 57
	FA56: full_adder port map(PL_REG_158, PL_REG_159, PL_REG_160(9), S(56), C(56));

	-- stage 58
	FA57: full_adder port map(PL_REG_161, PL_REG_162, PL_REG_163(9), S(57), C(57));

	-- stage 59
	FA58: full_adder port map(PL_REG_164, PL_REG_165, PL_REG_166(9), S(58), C(58));

	-- stage 60
	FA59: full_adder port map(PL_REG_167, PL_REG_168, PL_REG_169(9), S(59), C(59));

	-- stage 61
	FA60: full_adder port map(PL_REG_170, PL_REG_171, PL_REG_172(9), S(60), C(60));

	-- stage 62
	FA61: full_adder port map(PL_REG_173, PL_REG_174, PL_REG_175(9), S(61), C(61));

	-- stage 63
	FA62: full_adder port map(PL_REG_176, PL_REG_177, PL_REG_178(9), S(62), C(62));

	-- stage 64
	FA63: full_adder port map(PL_REG_179, PL_REG_180, PL_REG_181(9), S(63), C(63));

	-- stage 65
	FA64: full_adder port map(PL_REG_182, PL_REG_183, PL_REG_184(9), S(64), C(64));

	-- stage 66
	HA65: half_adder port map(PL_REG_185, PL_REG_186, S(65), C(65));

	-- stage 67
	FA66: full_adder port map(PL_REG_187, PL_REG_188, PL_REG_189(10), S(66), C(66));

	-- stage 68
	FA67: full_adder port map(PL_REG_190, PL_REG_191, PL_REG_192(10), S(67), C(67));

	-- stage 69
	FA68: full_adder port map(PL_REG_193, PL_REG_194, PL_REG_195(10), S(68), C(68));

	-- stage 70
	FA69: full_adder port map(PL_REG_196, PL_REG_197, PL_REG_198(10), S(69), C(69));

	-- stage 71
	FA70: full_adder port map(PL_REG_199, PL_REG_200, PL_REG_201(10), S(70), C(70));

	-- stage 72
	FA71: full_adder port map(PL_REG_202, PL_REG_203, PL_REG_204(10), S(71), C(71));

	-- stage 73
	FA72: full_adder port map(PL_REG_205, PL_REG_206, PL_REG_207(10), S(72), C(72));

	-- stage 74
	FA73: full_adder port map(PL_REG_208, PL_REG_209, PL_REG_210(10), S(73), C(73));

	-- stage 75
	FA74: full_adder port map(PL_REG_211, PL_REG_212, PL_REG_213(10), S(74), C(74));

	-- stage 76
	FA75: full_adder port map(PL_REG_214, PL_REG_215, PL_REG_216(10), S(75), C(75));

	-- stage 77
	FA76: full_adder port map(PL_REG_217, PL_REG_218, PL_REG_219(10), S(76), C(76));

	-- stage 78
	HA77: half_adder port map(PL_REG_220, PL_REG_221, S(77), C(77));

	-- stage 79
	FA78: full_adder port map(PL_REG_222, PL_REG_223, PL_REG_224(11), S(78), C(78));

	-- stage 80
	FA79: full_adder port map(PL_REG_225, PL_REG_226, PL_REG_227(11), S(79), C(79));

	-- stage 81
	FA80: full_adder port map(PL_REG_228, PL_REG_229, PL_REG_230(11), S(80), C(80));

	-- stage 82
	FA81: full_adder port map(PL_REG_231, PL_REG_232, PL_REG_233(11), S(81), C(81));

	-- stage 83
	FA82: full_adder port map(PL_REG_234, PL_REG_235, PL_REG_236(11), S(82), C(82));

	-- stage 84
	FA83: full_adder port map(PL_REG_237, PL_REG_238, PL_REG_239(11), S(83), C(83));

	-- stage 85
	FA84: full_adder port map(PL_REG_240, PL_REG_241, PL_REG_242(11), S(84), C(84));

	-- stage 86
	FA85: full_adder port map(PL_REG_243, PL_REG_244, PL_REG_245(11), S(85), C(85));

	-- stage 87
	FA86: full_adder port map(PL_REG_246, PL_REG_247, PL_REG_248(11), S(86), C(86));

	-- stage 88
	FA87: full_adder port map(PL_REG_249, PL_REG_250, PL_REG_251(11), S(87), C(87));

	-- stage 89
	FA88: full_adder port map(PL_REG_252, PL_REG_253, PL_REG_254(11), S(88), C(88));

	-- stage 90
	FA89: full_adder port map(PL_REG_255, PL_REG_256, PL_REG_257(11), S(89), C(89));

	-- stage 91
	HA90: half_adder port map(PL_REG_258, PL_REG_259, S(90), C(90));

	-- stage 92
	FA91: full_adder port map(PL_REG_260, PL_REG_261, PL_REG_262(12), S(91), C(91));

	-- stage 93
	FA92: full_adder port map(PL_REG_263, PL_REG_264, PL_REG_265(12), S(92), C(92));

	-- stage 94
	FA93: full_adder port map(PL_REG_266, PL_REG_267, PL_REG_268(12), S(93), C(93));

	-- stage 95
	FA94: full_adder port map(PL_REG_269, PL_REG_270, PL_REG_271(12), S(94), C(94));

	-- stage 96
	FA95: full_adder port map(PL_REG_272, PL_REG_273, PL_REG_274(12), S(95), C(95));

	-- stage 97
	FA96: full_adder port map(PL_REG_275, PL_REG_276, PL_REG_277(12), S(96), C(96));

	-- stage 98
	FA97: full_adder port map(PL_REG_278, PL_REG_279, PL_REG_280(12), S(97), C(97));

	-- stage 99
	FA98: full_adder port map(PL_REG_281, PL_REG_282, PL_REG_283(12), S(98), C(98));

	-- stage 100
	FA99: full_adder port map(PL_REG_284, PL_REG_285, PL_REG_286(12), S(99), C(99));

	-- stage 101
	FA100: full_adder port map(PL_REG_287, PL_REG_288, PL_REG_289(12), S(100), C(100));

	-- stage 102
	FA101: full_adder port map(PL_REG_290, PL_REG_291, PL_REG_292(12), S(101), C(101));

	-- stage 103
	FA102: full_adder port map(PL_REG_293, PL_REG_294, PL_REG_295(12), S(102), C(102));

	-- stage 104
	FA103: full_adder port map(PL_REG_296, PL_REG_297, PL_REG_298(12), S(103), C(103));

	-- stage 105
	HA104: half_adder port map(PL_REG_299, PL_REG_300, S(104), C(104));

	-- stage 106
	FA105: full_adder port map(PL_REG_301, PL_REG_302, PL_REG_303(13), S(105), C(105));

	-- stage 107
	FA106: full_adder port map(PL_REG_304, PL_REG_305, PL_REG_306(13), S(106), C(106));

	-- stage 108
	FA107: full_adder port map(PL_REG_307, PL_REG_308, PL_REG_309(13), S(107), C(107));

	-- stage 109
	FA108: full_adder port map(PL_REG_310, PL_REG_311, PL_REG_312(13), S(108), C(108));

	-- stage 110
	FA109: full_adder port map(PL_REG_313, PL_REG_314, PL_REG_315(13), S(109), C(109));

	-- stage 111
	FA110: full_adder port map(PL_REG_316, PL_REG_317, PL_REG_318(13), S(110), C(110));

	-- stage 112
	FA111: full_adder port map(PL_REG_319, PL_REG_320, PL_REG_321(13), S(111), C(111));

	-- stage 113
	FA112: full_adder port map(PL_REG_322, PL_REG_323, PL_REG_324(13), S(112), C(112));

	-- stage 114
	FA113: full_adder port map(PL_REG_325, PL_REG_326, PL_REG_327(13), S(113), C(113));

	-- stage 115
	FA114: full_adder port map(PL_REG_328, PL_REG_329, PL_REG_330(13), S(114), C(114));

	-- stage 116
	FA115: full_adder port map(PL_REG_331, PL_REG_332, PL_REG_333(13), S(115), C(115));

	-- stage 117
	FA116: full_adder port map(PL_REG_334, PL_REG_335, PL_REG_336(13), S(116), C(116));

	-- stage 118
	FA117: full_adder port map(PL_REG_337, PL_REG_338, PL_REG_339(13), S(117), C(117));

	-- stage 119
	FA118: full_adder port map(PL_REG_340, PL_REG_341, PL_REG_342(13), S(118), C(118));

	-- stage 120
	HA119: half_adder port map(PL_REG_343, PL_REG_344, S(119), C(119));

	-- stage 121
	HA120: half_adder port map(PL_REG_345(14), PL_REG_346, S(120), C(120));

	-- stage 122
	FA121: full_adder port map(PL_REG_347, PL_REG_348, PL_REG_349(14), S(121), C(121));

	-- stage 123
	FA122: full_adder port map(PL_REG_350, PL_REG_351, PL_REG_352(14), S(122), C(122));

	-- stage 124
	FA123: full_adder port map(PL_REG_353, PL_REG_354, PL_REG_355(14), S(123), C(123));

	-- stage 125
	FA124: full_adder port map(PL_REG_356, PL_REG_357, PL_REG_358(14), S(124), C(124));

	-- stage 126
	FA125: full_adder port map(PL_REG_359, PL_REG_360, PL_REG_361(14), S(125), C(125));

	-- stage 127
	FA126: full_adder port map(PL_REG_362, PL_REG_363, PL_REG_364(14), S(126), C(126));

	-- stage 128
	FA127: full_adder port map(PL_REG_365, PL_REG_366, PL_REG_367(14), S(127), C(127));

	-- stage 129
	FA128: full_adder port map(PL_REG_368, PL_REG_369, PL_REG_370(14), S(128), C(128));

	-- stage 130
	FA129: full_adder port map(PL_REG_371, PL_REG_372, PL_REG_373(14), S(129), C(129));

	-- stage 131
	FA130: full_adder port map(PL_REG_374, PL_REG_375, PL_REG_376(14), S(130), C(130));

	-- stage 132
	FA131: full_adder port map(PL_REG_377, PL_REG_378, PL_REG_379(14), S(131), C(131));

	-- stage 133
	FA132: full_adder port map(PL_REG_380, PL_REG_381, PL_REG_382(14), S(132), C(132));

	-- stage 134
	FA133: full_adder port map(PL_REG_383, PL_REG_384, PL_REG_385(14), S(133), C(133));

	-- stage 135
	FA134: full_adder port map(PL_REG_386, PL_REG_387, PL_REG_388(14), S(134), C(134));

	-- stage 136
	FA135: full_adder port map(PL_REG_389(14), PL_REG_390, PL_REG_391(13), S(135), C(135));

	-- stage 137
	FA136: full_adder port map(PL_REG_392, PL_REG_393, PL_REG_394(13), S(136), C(136));

	-- stage 138
	FA137: full_adder port map(PL_REG_395, PL_REG_396, PL_REG_397(13), S(137), C(137));

	-- stage 139
	FA138: full_adder port map(PL_REG_398, PL_REG_399, PL_REG_400(13), S(138), C(138));

	-- stage 140
	FA139: full_adder port map(PL_REG_401, PL_REG_402, PL_REG_403(13), S(139), C(139));

	-- stage 141
	FA140: full_adder port map(PL_REG_404, PL_REG_405, PL_REG_406(13), S(140), C(140));

	-- stage 142
	FA141: full_adder port map(PL_REG_407, PL_REG_408, PL_REG_409(13), S(141), C(141));

	-- stage 143
	FA142: full_adder port map(PL_REG_410, PL_REG_411, PL_REG_412(13), S(142), C(142));

	-- stage 144
	FA143: full_adder port map(PL_REG_413, PL_REG_414, PL_REG_415(13), S(143), C(143));

	-- stage 145
	FA144: full_adder port map(PL_REG_416, PL_REG_417, PL_REG_418(13), S(144), C(144));

	-- stage 146
	FA145: full_adder port map(PL_REG_419, PL_REG_420, PL_REG_421(13), S(145), C(145));

	-- stage 147
	FA146: full_adder port map(PL_REG_422, PL_REG_423, PL_REG_424(13), S(146), C(146));

	-- stage 148
	FA147: full_adder port map(PL_REG_425, PL_REG_426, PL_REG_427(13), S(147), C(147));

	-- stage 149
	FA148: full_adder port map(PL_REG_428, PL_REG_429, PL_REG_430(13), S(148), C(148));

	-- stage 150
	FA149: full_adder port map(PL_REG_431(13), PL_REG_432, PL_REG_433(12), S(149), C(149));

	-- stage 151
	FA150: full_adder port map(PL_REG_434, PL_REG_435, PL_REG_436(12), S(150), C(150));

	-- stage 152
	FA151: full_adder port map(PL_REG_437, PL_REG_438, PL_REG_439(12), S(151), C(151));

	-- stage 153
	FA152: full_adder port map(PL_REG_440, PL_REG_441, PL_REG_442(12), S(152), C(152));

	-- stage 154
	FA153: full_adder port map(PL_REG_443, PL_REG_444, PL_REG_445(12), S(153), C(153));

	-- stage 155
	FA154: full_adder port map(PL_REG_446, PL_REG_447, PL_REG_448(12), S(154), C(154));

	-- stage 156
	FA155: full_adder port map(PL_REG_449, PL_REG_450, PL_REG_451(12), S(155), C(155));

	-- stage 157
	FA156: full_adder port map(PL_REG_452, PL_REG_453, PL_REG_454(12), S(156), C(156));

	-- stage 158
	FA157: full_adder port map(PL_REG_455, PL_REG_456, PL_REG_457(12), S(157), C(157));

	-- stage 159
	FA158: full_adder port map(PL_REG_458, PL_REG_459, PL_REG_460(12), S(158), C(158));

	-- stage 160
	FA159: full_adder port map(PL_REG_461, PL_REG_462, PL_REG_463(12), S(159), C(159));

	-- stage 161
	FA160: full_adder port map(PL_REG_464, PL_REG_465, PL_REG_466(12), S(160), C(160));

	-- stage 162
	FA161: full_adder port map(PL_REG_467, PL_REG_468, PL_REG_469(12), S(161), C(161));

	-- stage 163
	FA162: full_adder port map(PL_REG_470(12), PL_REG_471, PL_REG_472(11), S(162), C(162));

	-- stage 164
	FA163: full_adder port map(PL_REG_473, PL_REG_474, PL_REG_475(11), S(163), C(163));

	-- stage 165
	FA164: full_adder port map(PL_REG_476, PL_REG_477, PL_REG_478(11), S(164), C(164));

	-- stage 166
	FA165: full_adder port map(PL_REG_479, PL_REG_480, PL_REG_481(11), S(165), C(165));

	-- stage 167
	FA166: full_adder port map(PL_REG_482, PL_REG_483, PL_REG_484(11), S(166), C(166));

	-- stage 168
	FA167: full_adder port map(PL_REG_485, PL_REG_486, PL_REG_487(11), S(167), C(167));

	-- stage 169
	FA168: full_adder port map(PL_REG_488, PL_REG_489, PL_REG_490(11), S(168), C(168));

	-- stage 170
	FA169: full_adder port map(PL_REG_491, PL_REG_492, PL_REG_493(11), S(169), C(169));

	-- stage 171
	FA170: full_adder port map(PL_REG_494, PL_REG_495, PL_REG_496(11), S(170), C(170));

	-- stage 172
	FA171: full_adder port map(PL_REG_497, PL_REG_498, PL_REG_499(11), S(171), C(171));

	-- stage 173
	FA172: full_adder port map(PL_REG_500, PL_REG_501, PL_REG_502(11), S(172), C(172));

	-- stage 174
	FA173: full_adder port map(PL_REG_503, PL_REG_504, PL_REG_505(11), S(173), C(173));

	-- stage 175
	FA174: full_adder port map(PL_REG_506(11), PL_REG_507, PL_REG_508(10), S(174), C(174));

	-- stage 176
	FA175: full_adder port map(PL_REG_509, PL_REG_510, PL_REG_511(10), S(175), C(175));

	-- stage 177
	FA176: full_adder port map(PL_REG_512, PL_REG_513, PL_REG_514(10), S(176), C(176));

	-- stage 178
	FA177: full_adder port map(PL_REG_515, PL_REG_516, PL_REG_517(10), S(177), C(177));

	-- stage 179
	FA178: full_adder port map(PL_REG_518, PL_REG_519, PL_REG_520(10), S(178), C(178));

	-- stage 180
	FA179: full_adder port map(PL_REG_521, PL_REG_522, PL_REG_523(10), S(179), C(179));

	-- stage 181
	FA180: full_adder port map(PL_REG_524, PL_REG_525, PL_REG_526(10), S(180), C(180));

	-- stage 182
	FA181: full_adder port map(PL_REG_527, PL_REG_528, PL_REG_529(10), S(181), C(181));

	-- stage 183
	FA182: full_adder port map(PL_REG_530, PL_REG_531, PL_REG_532(10), S(182), C(182));

	-- stage 184
	FA183: full_adder port map(PL_REG_533, PL_REG_534, PL_REG_535(10), S(183), C(183));

	-- stage 185
	FA184: full_adder port map(PL_REG_536, PL_REG_537, PL_REG_538(10), S(184), C(184));

	-- stage 186
	FA185: full_adder port map(PL_REG_539(10), PL_REG_540, PL_REG_541(9), S(185), C(185));

	-- stage 187
	FA186: full_adder port map(PL_REG_542, PL_REG_543, PL_REG_544(9), S(186), C(186));

	-- stage 188
	FA187: full_adder port map(PL_REG_545, PL_REG_546, PL_REG_547(9), S(187), C(187));

	-- stage 189
	FA188: full_adder port map(PL_REG_548, PL_REG_549, PL_REG_550(9), S(188), C(188));

	-- stage 190
	FA189: full_adder port map(PL_REG_551, PL_REG_552, PL_REG_553(9), S(189), C(189));

	-- stage 191
	FA190: full_adder port map(PL_REG_554, PL_REG_555, PL_REG_556(9), S(190), C(190));

	-- stage 192
	FA191: full_adder port map(PL_REG_557, PL_REG_558, PL_REG_559(9), S(191), C(191));

	-- stage 193
	FA192: full_adder port map(PL_REG_560, PL_REG_561, PL_REG_562(9), S(192), C(192));

	-- stage 194
	FA193: full_adder port map(PL_REG_563, PL_REG_564, PL_REG_565(9), S(193), C(193));

	-- stage 195
	FA194: full_adder port map(PL_REG_566, PL_REG_567, PL_REG_568(9), S(194), C(194));

	-- stage 196
	FA195: full_adder port map(PL_REG_569(9), PL_REG_570, PL_REG_571(8), S(195), C(195));

	-- stage 197
	FA196: full_adder port map(PL_REG_572, PL_REG_573, PL_REG_574(8), S(196), C(196));

	-- stage 198
	FA197: full_adder port map(PL_REG_575, PL_REG_576, PL_REG_577(8), S(197), C(197));

	-- stage 199
	FA198: full_adder port map(PL_REG_578, PL_REG_579, PL_REG_580(8), S(198), C(198));

	-- stage 200
	FA199: full_adder port map(PL_REG_581, PL_REG_582, PL_REG_583(8), S(199), C(199));

	-- stage 201
	FA200: full_adder port map(PL_REG_584, PL_REG_585, PL_REG_586(8), S(200), C(200));

	-- stage 202
	FA201: full_adder port map(PL_REG_587, PL_REG_588, PL_REG_589(8), S(201), C(201));

	-- stage 203
	FA202: full_adder port map(PL_REG_590, PL_REG_591, PL_REG_592(8), S(202), C(202));

	-- stage 204
	FA203: full_adder port map(PL_REG_593, PL_REG_594, PL_REG_595(8), S(203), C(203));

	-- stage 205
	FA204: full_adder port map(PL_REG_596(8), PL_REG_597, PL_REG_598(7), S(204), C(204));

	-- stage 206
	FA205: full_adder port map(PL_REG_599, PL_REG_600, PL_REG_601(7), S(205), C(205));

	-- stage 207
	FA206: full_adder port map(PL_REG_602, PL_REG_603, PL_REG_604(7), S(206), C(206));

	-- stage 208
	FA207: full_adder port map(PL_REG_605, PL_REG_606, PL_REG_607(7), S(207), C(207));

	-- stage 209
	FA208: full_adder port map(PL_REG_608, PL_REG_609, PL_REG_610(7), S(208), C(208));

	-- stage 210
	FA209: full_adder port map(PL_REG_611, PL_REG_612, PL_REG_613(7), S(209), C(209));

	-- stage 211
	FA210: full_adder port map(PL_REG_614, PL_REG_615, PL_REG_616(7), S(210), C(210));

	-- stage 212
	FA211: full_adder port map(PL_REG_617, PL_REG_618, PL_REG_619(7), S(211), C(211));

	-- stage 213
	FA212: full_adder port map(PL_REG_620(7), PL_REG_621, PL_REG_622(6), S(212), C(212));

	-- stage 214
	FA213: full_adder port map(PL_REG_623, PL_REG_624, PL_REG_625(6), S(213), C(213));

	-- stage 215
	FA214: full_adder port map(PL_REG_626, PL_REG_627, PL_REG_628(6), S(214), C(214));

	-- stage 216
	FA215: full_adder port map(PL_REG_629, PL_REG_630, PL_REG_631(6), S(215), C(215));

	-- stage 217
	FA216: full_adder port map(PL_REG_632, PL_REG_633, PL_REG_634(6), S(216), C(216));

	-- stage 218
	FA217: full_adder port map(PL_REG_635, PL_REG_636, PL_REG_637(6), S(217), C(217));

	-- stage 219
	FA218: full_adder port map(PL_REG_638, PL_REG_639, PL_REG_640(6), S(218), C(218));

	-- stage 220
	FA219: full_adder port map(PL_REG_641(6), PL_REG_642, PL_REG_643(5), S(219), C(219));

	-- stage 221
	FA220: full_adder port map(PL_REG_644, PL_REG_645, PL_REG_646(5), S(220), C(220));

	-- stage 222
	FA221: full_adder port map(PL_REG_647, PL_REG_648, PL_REG_649(5), S(221), C(221));

	-- stage 223
	FA222: full_adder port map(PL_REG_650, PL_REG_651, PL_REG_652(5), S(222), C(222));

	-- stage 224
	FA223: full_adder port map(PL_REG_653, PL_REG_654, PL_REG_655(5), S(223), C(223));

	-- stage 225
	FA224: full_adder port map(PL_REG_656, PL_REG_657, PL_REG_658(5), S(224), C(224));

	-- stage 226
	FA225: full_adder port map(PL_REG_659(5), PL_REG_660, PL_REG_661(4), S(225), C(225));

	-- stage 227
	FA226: full_adder port map(PL_REG_662, PL_REG_663, PL_REG_664(4), S(226), C(226));

	-- stage 228
	FA227: full_adder port map(PL_REG_665, PL_REG_666, PL_REG_667(4), S(227), C(227));

	-- stage 229
	FA228: full_adder port map(PL_REG_668, PL_REG_669, PL_REG_670(4), S(228), C(228));

	-- stage 230
	FA229: full_adder port map(PL_REG_671, PL_REG_672, PL_REG_673(4), S(229), C(229));

	-- stage 231
	FA230: full_adder port map(PL_REG_674(4), PL_REG_675, PL_REG_676(3), S(230), C(230));

	-- stage 232
	FA231: full_adder port map(PL_REG_677, PL_REG_678, PL_REG_679(3), S(231), C(231));

	-- stage 233
	FA232: full_adder port map(PL_REG_680, PL_REG_681, PL_REG_682(3), S(232), C(232));

	-- stage 234
	FA233: full_adder port map(PL_REG_683, PL_REG_684, PL_REG_685(3), S(233), C(233));

	-- stage 235
	FA234: full_adder port map(PL_REG_686(3), PL_REG_687, PL_REG_688(2), S(234), C(234));

	-- stage 236
	FA235: full_adder port map(PL_REG_689, PL_REG_690, PL_REG_691(2), S(235), C(235));

	-- stage 237
	FA236: full_adder port map(PL_REG_692, PL_REG_693, PL_REG_694(2), S(236), C(236));

	-- stage 238
	FA237: full_adder port map(PL_REG_695(2), PL_REG_696, PL_REG_697(1), S(237), C(237));

	-- stage 239
	FA238: full_adder port map(PL_REG_698, PL_REG_699, PL_REG_700(1), S(238), C(238));

	-- stage 240
	FA239: full_adder port map(PL_REG_701(1), PL_REG_702, PL_REG_703, S(239), C(239));

	-- stage 241

  process(clk)
  begin
    if rising_edge(clk) then
      if start = '1' then
        -- stage 0
        valid <= valid(240 downto 0) & '1';
        
        for i in 0 to 15 loop
          A1(0, i) <= A(i);
          B1(0, i) <= B(i);
        end loop;
      else
        valid <= valid(240 downto 0) & '0';
      end if;
      
      -- shift registers pipeline forward
      for i in 239 downto 0 loop
        for j in 0 to 15 loop 
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
		Y0 <= Y0(238 downto 0) & (A1(1, 0) and B1(1, 0));
		Y1 <= Y1(238 downto 0) & S(0);
		PL_REG_2 <= A1(1, 0) and B1(1, 2); -- Stage used in = 3
		PL_REG_3 <= A1(1, 1) and B1(1, 1); -- Stage used in = 3
		PL_REG_4 <= C(0); -- Stage used in = 3

		-- stage 3
		PL_REG_5 <= S(1); -- Stage used in = 4
		PL_REG_6 <= A1(2, 2) and B1(2, 0); -- Stage used in = 4
		PL_REG_9 <= PL_REG_9(0 downto 0) & C(1); -- Stage used in = 5

		-- stage 4
		Y2 <= Y2(236 downto 0) & S(2);
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
		Y3 <= Y3(233 downto 0) & S(5);
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
		Y4 <= Y4(229 downto 0) & S(9);
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
		Y5 <= Y5(224 downto 0) & S(14);
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
		Y6 <= Y6(218 downto 0) & S(20);
		PL_REG_57 <= A1(21, 0) and B1(21, 7); -- Stage used in = 23
		PL_REG_58 <= A1(21, 1) and B1(21, 6); -- Stage used in = 23
		PL_REG_74 <= PL_REG_74(4 downto 0) & C(20); -- Stage used in = 28

		-- stage 23
		PL_REG_60 <= S(21); -- Stage used in = 24
		PL_REG_61 <= A1(22, 2) and B1(22, 5); -- Stage used in = 24
		PL_REG_79 <= PL_REG_79(5 downto 0) & C(21); -- Stage used in = 30

		-- stage 24
		PL_REG_63 <= S(22); -- Stage used in = 25
		PL_REG_64 <= A1(23, 3) and B1(23, 4); -- Stage used in = 25
		PL_REG_82 <= PL_REG_82(5 downto 0) & C(22); -- Stage used in = 31

		-- stage 25
		PL_REG_66 <= S(23); -- Stage used in = 26
		PL_REG_67 <= A1(24, 4) and B1(24, 3); -- Stage used in = 26
		PL_REG_85 <= PL_REG_85(5 downto 0) & C(23); -- Stage used in = 32

		-- stage 26
		PL_REG_69 <= S(24); -- Stage used in = 27
		PL_REG_70 <= A1(25, 5) and B1(25, 2); -- Stage used in = 27
		PL_REG_88 <= PL_REG_88(5 downto 0) & C(24); -- Stage used in = 33

		-- stage 27
		PL_REG_72 <= S(25); -- Stage used in = 28
		PL_REG_73 <= A1(26, 6) and B1(26, 1); -- Stage used in = 28
		PL_REG_91 <= PL_REG_91(5 downto 0) & C(25); -- Stage used in = 34

		-- stage 28
		PL_REG_75 <= S(26); -- Stage used in = 29
		PL_REG_76 <= A1(27, 7) and B1(27, 0); -- Stage used in = 29
		PL_REG_94 <= PL_REG_94(5 downto 0) & C(26); -- Stage used in = 35

		-- stage 29
		Y7 <= Y7(211 downto 0) & S(27);
		PL_REG_77 <= A1(28, 0) and B1(28, 8); -- Stage used in = 30
		PL_REG_78 <= A1(28, 1) and B1(28, 7); -- Stage used in = 30
		PL_REG_97 <= PL_REG_97(5 downto 0) & C(27); -- Stage used in = 36

		-- stage 30
		PL_REG_80 <= S(28); -- Stage used in = 31
		PL_REG_81 <= A1(29, 2) and B1(29, 6); -- Stage used in = 31
		PL_REG_102 <= PL_REG_102(6 downto 0) & C(28); -- Stage used in = 38

		-- stage 31
		PL_REG_83 <= S(29); -- Stage used in = 32
		PL_REG_84 <= A1(30, 3) and B1(30, 5); -- Stage used in = 32
		PL_REG_105 <= PL_REG_105(6 downto 0) & C(29); -- Stage used in = 39

		-- stage 32
		PL_REG_86 <= S(30); -- Stage used in = 33
		PL_REG_87 <= A1(31, 4) and B1(31, 4); -- Stage used in = 33
		PL_REG_108 <= PL_REG_108(6 downto 0) & C(30); -- Stage used in = 40

		-- stage 33
		PL_REG_89 <= S(31); -- Stage used in = 34
		PL_REG_90 <= A1(32, 5) and B1(32, 3); -- Stage used in = 34
		PL_REG_111 <= PL_REG_111(6 downto 0) & C(31); -- Stage used in = 41

		-- stage 34
		PL_REG_92 <= S(32); -- Stage used in = 35
		PL_REG_93 <= A1(33, 6) and B1(33, 2); -- Stage used in = 35
		PL_REG_114 <= PL_REG_114(6 downto 0) & C(32); -- Stage used in = 42

		-- stage 35
		PL_REG_95 <= S(33); -- Stage used in = 36
		PL_REG_96 <= A1(34, 7) and B1(34, 1); -- Stage used in = 36
		PL_REG_117 <= PL_REG_117(6 downto 0) & C(33); -- Stage used in = 43

		-- stage 36
		PL_REG_98 <= S(34); -- Stage used in = 37
		PL_REG_99 <= A1(35, 8) and B1(35, 0); -- Stage used in = 37
		PL_REG_120 <= PL_REG_120(6 downto 0) & C(34); -- Stage used in = 44

		-- stage 37
		Y8 <= Y8(203 downto 0) & S(35);
		PL_REG_100 <= A1(36, 0) and B1(36, 9); -- Stage used in = 38
		PL_REG_101 <= A1(36, 1) and B1(36, 8); -- Stage used in = 38
		PL_REG_123 <= PL_REG_123(6 downto 0) & C(35); -- Stage used in = 45

		-- stage 38
		PL_REG_103 <= S(36); -- Stage used in = 39
		PL_REG_104 <= A1(37, 2) and B1(37, 7); -- Stage used in = 39
		PL_REG_128 <= PL_REG_128(7 downto 0) & C(36); -- Stage used in = 47

		-- stage 39
		PL_REG_106 <= S(37); -- Stage used in = 40
		PL_REG_107 <= A1(38, 3) and B1(38, 6); -- Stage used in = 40
		PL_REG_131 <= PL_REG_131(7 downto 0) & C(37); -- Stage used in = 48

		-- stage 40
		PL_REG_109 <= S(38); -- Stage used in = 41
		PL_REG_110 <= A1(39, 4) and B1(39, 5); -- Stage used in = 41
		PL_REG_134 <= PL_REG_134(7 downto 0) & C(38); -- Stage used in = 49

		-- stage 41
		PL_REG_112 <= S(39); -- Stage used in = 42
		PL_REG_113 <= A1(40, 5) and B1(40, 4); -- Stage used in = 42
		PL_REG_137 <= PL_REG_137(7 downto 0) & C(39); -- Stage used in = 50

		-- stage 42
		PL_REG_115 <= S(40); -- Stage used in = 43
		PL_REG_116 <= A1(41, 6) and B1(41, 3); -- Stage used in = 43
		PL_REG_140 <= PL_REG_140(7 downto 0) & C(40); -- Stage used in = 51

		-- stage 43
		PL_REG_118 <= S(41); -- Stage used in = 44
		PL_REG_119 <= A1(42, 7) and B1(42, 2); -- Stage used in = 44
		PL_REG_143 <= PL_REG_143(7 downto 0) & C(41); -- Stage used in = 52

		-- stage 44
		PL_REG_121 <= S(42); -- Stage used in = 45
		PL_REG_122 <= A1(43, 8) and B1(43, 1); -- Stage used in = 45
		PL_REG_146 <= PL_REG_146(7 downto 0) & C(42); -- Stage used in = 53

		-- stage 45
		PL_REG_124 <= S(43); -- Stage used in = 46
		PL_REG_125 <= A1(44, 9) and B1(44, 0); -- Stage used in = 46
		PL_REG_149 <= PL_REG_149(7 downto 0) & C(43); -- Stage used in = 54

		-- stage 46
		Y9 <= Y9(194 downto 0) & S(44);
		PL_REG_126 <= A1(45, 0) and B1(45, 10); -- Stage used in = 47
		PL_REG_127 <= A1(45, 1) and B1(45, 9); -- Stage used in = 47
		PL_REG_152 <= PL_REG_152(7 downto 0) & C(44); -- Stage used in = 55

		-- stage 47
		PL_REG_129 <= S(45); -- Stage used in = 48
		PL_REG_130 <= A1(46, 2) and B1(46, 8); -- Stage used in = 48
		PL_REG_157 <= PL_REG_157(8 downto 0) & C(45); -- Stage used in = 57

		-- stage 48
		PL_REG_132 <= S(46); -- Stage used in = 49
		PL_REG_133 <= A1(47, 3) and B1(47, 7); -- Stage used in = 49
		PL_REG_160 <= PL_REG_160(8 downto 0) & C(46); -- Stage used in = 58

		-- stage 49
		PL_REG_135 <= S(47); -- Stage used in = 50
		PL_REG_136 <= A1(48, 4) and B1(48, 6); -- Stage used in = 50
		PL_REG_163 <= PL_REG_163(8 downto 0) & C(47); -- Stage used in = 59

		-- stage 50
		PL_REG_138 <= S(48); -- Stage used in = 51
		PL_REG_139 <= A1(49, 5) and B1(49, 5); -- Stage used in = 51
		PL_REG_166 <= PL_REG_166(8 downto 0) & C(48); -- Stage used in = 60

		-- stage 51
		PL_REG_141 <= S(49); -- Stage used in = 52
		PL_REG_142 <= A1(50, 6) and B1(50, 4); -- Stage used in = 52
		PL_REG_169 <= PL_REG_169(8 downto 0) & C(49); -- Stage used in = 61

		-- stage 52
		PL_REG_144 <= S(50); -- Stage used in = 53
		PL_REG_145 <= A1(51, 7) and B1(51, 3); -- Stage used in = 53
		PL_REG_172 <= PL_REG_172(8 downto 0) & C(50); -- Stage used in = 62

		-- stage 53
		PL_REG_147 <= S(51); -- Stage used in = 54
		PL_REG_148 <= A1(52, 8) and B1(52, 2); -- Stage used in = 54
		PL_REG_175 <= PL_REG_175(8 downto 0) & C(51); -- Stage used in = 63

		-- stage 54
		PL_REG_150 <= S(52); -- Stage used in = 55
		PL_REG_151 <= A1(53, 9) and B1(53, 1); -- Stage used in = 55
		PL_REG_178 <= PL_REG_178(8 downto 0) & C(52); -- Stage used in = 64

		-- stage 55
		PL_REG_153 <= S(53); -- Stage used in = 56
		PL_REG_154 <= A1(54, 10) and B1(54, 0); -- Stage used in = 56
		PL_REG_181 <= PL_REG_181(8 downto 0) & C(53); -- Stage used in = 65

		-- stage 56
		Y10 <= Y10(184 downto 0) & S(54);
		PL_REG_155 <= A1(55, 0) and B1(55, 11); -- Stage used in = 57
		PL_REG_156 <= A1(55, 1) and B1(55, 10); -- Stage used in = 57
		PL_REG_184 <= PL_REG_184(8 downto 0) & C(54); -- Stage used in = 66

		-- stage 57
		PL_REG_158 <= S(55); -- Stage used in = 58
		PL_REG_159 <= A1(56, 2) and B1(56, 9); -- Stage used in = 58
		PL_REG_189 <= PL_REG_189(9 downto 0) & C(55); -- Stage used in = 68

		-- stage 58
		PL_REG_161 <= S(56); -- Stage used in = 59
		PL_REG_162 <= A1(57, 3) and B1(57, 8); -- Stage used in = 59
		PL_REG_192 <= PL_REG_192(9 downto 0) & C(56); -- Stage used in = 69

		-- stage 59
		PL_REG_164 <= S(57); -- Stage used in = 60
		PL_REG_165 <= A1(58, 4) and B1(58, 7); -- Stage used in = 60
		PL_REG_195 <= PL_REG_195(9 downto 0) & C(57); -- Stage used in = 70

		-- stage 60
		PL_REG_167 <= S(58); -- Stage used in = 61
		PL_REG_168 <= A1(59, 5) and B1(59, 6); -- Stage used in = 61
		PL_REG_198 <= PL_REG_198(9 downto 0) & C(58); -- Stage used in = 71

		-- stage 61
		PL_REG_170 <= S(59); -- Stage used in = 62
		PL_REG_171 <= A1(60, 6) and B1(60, 5); -- Stage used in = 62
		PL_REG_201 <= PL_REG_201(9 downto 0) & C(59); -- Stage used in = 72

		-- stage 62
		PL_REG_173 <= S(60); -- Stage used in = 63
		PL_REG_174 <= A1(61, 7) and B1(61, 4); -- Stage used in = 63
		PL_REG_204 <= PL_REG_204(9 downto 0) & C(60); -- Stage used in = 73

		-- stage 63
		PL_REG_176 <= S(61); -- Stage used in = 64
		PL_REG_177 <= A1(62, 8) and B1(62, 3); -- Stage used in = 64
		PL_REG_207 <= PL_REG_207(9 downto 0) & C(61); -- Stage used in = 74

		-- stage 64
		PL_REG_179 <= S(62); -- Stage used in = 65
		PL_REG_180 <= A1(63, 9) and B1(63, 2); -- Stage used in = 65
		PL_REG_210 <= PL_REG_210(9 downto 0) & C(62); -- Stage used in = 75

		-- stage 65
		PL_REG_182 <= S(63); -- Stage used in = 66
		PL_REG_183 <= A1(64, 10) and B1(64, 1); -- Stage used in = 66
		PL_REG_213 <= PL_REG_213(9 downto 0) & C(63); -- Stage used in = 76

		-- stage 66
		PL_REG_185 <= S(64); -- Stage used in = 67
		PL_REG_186 <= A1(65, 11) and B1(65, 0); -- Stage used in = 67
		PL_REG_216 <= PL_REG_216(9 downto 0) & C(64); -- Stage used in = 77

		-- stage 67
		Y11 <= Y11(173 downto 0) & S(65);
		PL_REG_187 <= A1(66, 0) and B1(66, 12); -- Stage used in = 68
		PL_REG_188 <= A1(66, 1) and B1(66, 11); -- Stage used in = 68
		PL_REG_219 <= PL_REG_219(9 downto 0) & C(65); -- Stage used in = 78

		-- stage 68
		PL_REG_190 <= S(66); -- Stage used in = 69
		PL_REG_191 <= A1(67, 2) and B1(67, 10); -- Stage used in = 69
		PL_REG_224 <= PL_REG_224(10 downto 0) & C(66); -- Stage used in = 80

		-- stage 69
		PL_REG_193 <= S(67); -- Stage used in = 70
		PL_REG_194 <= A1(68, 3) and B1(68, 9); -- Stage used in = 70
		PL_REG_227 <= PL_REG_227(10 downto 0) & C(67); -- Stage used in = 81

		-- stage 70
		PL_REG_196 <= S(68); -- Stage used in = 71
		PL_REG_197 <= A1(69, 4) and B1(69, 8); -- Stage used in = 71
		PL_REG_230 <= PL_REG_230(10 downto 0) & C(68); -- Stage used in = 82

		-- stage 71
		PL_REG_199 <= S(69); -- Stage used in = 72
		PL_REG_200 <= A1(70, 5) and B1(70, 7); -- Stage used in = 72
		PL_REG_233 <= PL_REG_233(10 downto 0) & C(69); -- Stage used in = 83

		-- stage 72
		PL_REG_202 <= S(70); -- Stage used in = 73
		PL_REG_203 <= A1(71, 6) and B1(71, 6); -- Stage used in = 73
		PL_REG_236 <= PL_REG_236(10 downto 0) & C(70); -- Stage used in = 84

		-- stage 73
		PL_REG_205 <= S(71); -- Stage used in = 74
		PL_REG_206 <= A1(72, 7) and B1(72, 5); -- Stage used in = 74
		PL_REG_239 <= PL_REG_239(10 downto 0) & C(71); -- Stage used in = 85

		-- stage 74
		PL_REG_208 <= S(72); -- Stage used in = 75
		PL_REG_209 <= A1(73, 8) and B1(73, 4); -- Stage used in = 75
		PL_REG_242 <= PL_REG_242(10 downto 0) & C(72); -- Stage used in = 86

		-- stage 75
		PL_REG_211 <= S(73); -- Stage used in = 76
		PL_REG_212 <= A1(74, 9) and B1(74, 3); -- Stage used in = 76
		PL_REG_245 <= PL_REG_245(10 downto 0) & C(73); -- Stage used in = 87

		-- stage 76
		PL_REG_214 <= S(74); -- Stage used in = 77
		PL_REG_215 <= A1(75, 10) and B1(75, 2); -- Stage used in = 77
		PL_REG_248 <= PL_REG_248(10 downto 0) & C(74); -- Stage used in = 88

		-- stage 77
		PL_REG_217 <= S(75); -- Stage used in = 78
		PL_REG_218 <= A1(76, 11) and B1(76, 1); -- Stage used in = 78
		PL_REG_251 <= PL_REG_251(10 downto 0) & C(75); -- Stage used in = 89

		-- stage 78
		PL_REG_220 <= S(76); -- Stage used in = 79
		PL_REG_221 <= A1(77, 12) and B1(77, 0); -- Stage used in = 79
		PL_REG_254 <= PL_REG_254(10 downto 0) & C(76); -- Stage used in = 90

		-- stage 79
		Y12 <= Y12(161 downto 0) & S(77);
		PL_REG_222 <= A1(78, 0) and B1(78, 13); -- Stage used in = 80
		PL_REG_223 <= A1(78, 1) and B1(78, 12); -- Stage used in = 80
		PL_REG_257 <= PL_REG_257(10 downto 0) & C(77); -- Stage used in = 91

		-- stage 80
		PL_REG_225 <= S(78); -- Stage used in = 81
		PL_REG_226 <= A1(79, 2) and B1(79, 11); -- Stage used in = 81
		PL_REG_262 <= PL_REG_262(11 downto 0) & C(78); -- Stage used in = 93

		-- stage 81
		PL_REG_228 <= S(79); -- Stage used in = 82
		PL_REG_229 <= A1(80, 3) and B1(80, 10); -- Stage used in = 82
		PL_REG_265 <= PL_REG_265(11 downto 0) & C(79); -- Stage used in = 94

		-- stage 82
		PL_REG_231 <= S(80); -- Stage used in = 83
		PL_REG_232 <= A1(81, 4) and B1(81, 9); -- Stage used in = 83
		PL_REG_268 <= PL_REG_268(11 downto 0) & C(80); -- Stage used in = 95

		-- stage 83
		PL_REG_234 <= S(81); -- Stage used in = 84
		PL_REG_235 <= A1(82, 5) and B1(82, 8); -- Stage used in = 84
		PL_REG_271 <= PL_REG_271(11 downto 0) & C(81); -- Stage used in = 96

		-- stage 84
		PL_REG_237 <= S(82); -- Stage used in = 85
		PL_REG_238 <= A1(83, 6) and B1(83, 7); -- Stage used in = 85
		PL_REG_274 <= PL_REG_274(11 downto 0) & C(82); -- Stage used in = 97

		-- stage 85
		PL_REG_240 <= S(83); -- Stage used in = 86
		PL_REG_241 <= A1(84, 7) and B1(84, 6); -- Stage used in = 86
		PL_REG_277 <= PL_REG_277(11 downto 0) & C(83); -- Stage used in = 98

		-- stage 86
		PL_REG_243 <= S(84); -- Stage used in = 87
		PL_REG_244 <= A1(85, 8) and B1(85, 5); -- Stage used in = 87
		PL_REG_280 <= PL_REG_280(11 downto 0) & C(84); -- Stage used in = 99

		-- stage 87
		PL_REG_246 <= S(85); -- Stage used in = 88
		PL_REG_247 <= A1(86, 9) and B1(86, 4); -- Stage used in = 88
		PL_REG_283 <= PL_REG_283(11 downto 0) & C(85); -- Stage used in = 100

		-- stage 88
		PL_REG_249 <= S(86); -- Stage used in = 89
		PL_REG_250 <= A1(87, 10) and B1(87, 3); -- Stage used in = 89
		PL_REG_286 <= PL_REG_286(11 downto 0) & C(86); -- Stage used in = 101

		-- stage 89
		PL_REG_252 <= S(87); -- Stage used in = 90
		PL_REG_253 <= A1(88, 11) and B1(88, 2); -- Stage used in = 90
		PL_REG_289 <= PL_REG_289(11 downto 0) & C(87); -- Stage used in = 102

		-- stage 90
		PL_REG_255 <= S(88); -- Stage used in = 91
		PL_REG_256 <= A1(89, 12) and B1(89, 1); -- Stage used in = 91
		PL_REG_292 <= PL_REG_292(11 downto 0) & C(88); -- Stage used in = 103

		-- stage 91
		PL_REG_258 <= S(89); -- Stage used in = 92
		PL_REG_259 <= A1(90, 13) and B1(90, 0); -- Stage used in = 92
		PL_REG_295 <= PL_REG_295(11 downto 0) & C(89); -- Stage used in = 104

		-- stage 92
		Y13 <= Y13(148 downto 0) & S(90);
		PL_REG_260 <= A1(91, 0) and B1(91, 14); -- Stage used in = 93
		PL_REG_261 <= A1(91, 1) and B1(91, 13); -- Stage used in = 93
		PL_REG_298 <= PL_REG_298(11 downto 0) & C(90); -- Stage used in = 105

		-- stage 93
		PL_REG_263 <= S(91); -- Stage used in = 94
		PL_REG_264 <= A1(92, 2) and B1(92, 12); -- Stage used in = 94
		PL_REG_303 <= PL_REG_303(12 downto 0) & C(91); -- Stage used in = 107

		-- stage 94
		PL_REG_266 <= S(92); -- Stage used in = 95
		PL_REG_267 <= A1(93, 3) and B1(93, 11); -- Stage used in = 95
		PL_REG_306 <= PL_REG_306(12 downto 0) & C(92); -- Stage used in = 108

		-- stage 95
		PL_REG_269 <= S(93); -- Stage used in = 96
		PL_REG_270 <= A1(94, 4) and B1(94, 10); -- Stage used in = 96
		PL_REG_309 <= PL_REG_309(12 downto 0) & C(93); -- Stage used in = 109

		-- stage 96
		PL_REG_272 <= S(94); -- Stage used in = 97
		PL_REG_273 <= A1(95, 5) and B1(95, 9); -- Stage used in = 97
		PL_REG_312 <= PL_REG_312(12 downto 0) & C(94); -- Stage used in = 110

		-- stage 97
		PL_REG_275 <= S(95); -- Stage used in = 98
		PL_REG_276 <= A1(96, 6) and B1(96, 8); -- Stage used in = 98
		PL_REG_315 <= PL_REG_315(12 downto 0) & C(95); -- Stage used in = 111

		-- stage 98
		PL_REG_278 <= S(96); -- Stage used in = 99
		PL_REG_279 <= A1(97, 7) and B1(97, 7); -- Stage used in = 99
		PL_REG_318 <= PL_REG_318(12 downto 0) & C(96); -- Stage used in = 112

		-- stage 99
		PL_REG_281 <= S(97); -- Stage used in = 100
		PL_REG_282 <= A1(98, 8) and B1(98, 6); -- Stage used in = 100
		PL_REG_321 <= PL_REG_321(12 downto 0) & C(97); -- Stage used in = 113

		-- stage 100
		PL_REG_284 <= S(98); -- Stage used in = 101
		PL_REG_285 <= A1(99, 9) and B1(99, 5); -- Stage used in = 101
		PL_REG_324 <= PL_REG_324(12 downto 0) & C(98); -- Stage used in = 114

		-- stage 101
		PL_REG_287 <= S(99); -- Stage used in = 102
		PL_REG_288 <= A1(100, 10) and B1(100, 4); -- Stage used in = 102
		PL_REG_327 <= PL_REG_327(12 downto 0) & C(99); -- Stage used in = 115

		-- stage 102
		PL_REG_290 <= S(100); -- Stage used in = 103
		PL_REG_291 <= A1(101, 11) and B1(101, 3); -- Stage used in = 103
		PL_REG_330 <= PL_REG_330(12 downto 0) & C(100); -- Stage used in = 116

		-- stage 103
		PL_REG_293 <= S(101); -- Stage used in = 104
		PL_REG_294 <= A1(102, 12) and B1(102, 2); -- Stage used in = 104
		PL_REG_333 <= PL_REG_333(12 downto 0) & C(101); -- Stage used in = 117

		-- stage 104
		PL_REG_296 <= S(102); -- Stage used in = 105
		PL_REG_297 <= A1(103, 13) and B1(103, 1); -- Stage used in = 105
		PL_REG_336 <= PL_REG_336(12 downto 0) & C(102); -- Stage used in = 118

		-- stage 105
		PL_REG_299 <= S(103); -- Stage used in = 106
		PL_REG_300 <= A1(104, 14) and B1(104, 0); -- Stage used in = 106
		PL_REG_339 <= PL_REG_339(12 downto 0) & C(103); -- Stage used in = 119

		-- stage 106
		Y14 <= Y14(134 downto 0) & S(104);
		PL_REG_301 <= A1(105, 0) and B1(105, 15); -- Stage used in = 107
		PL_REG_302 <= A1(105, 1) and B1(105, 14); -- Stage used in = 107
		PL_REG_342 <= PL_REG_342(12 downto 0) & C(104); -- Stage used in = 120

		-- stage 107
		PL_REG_304 <= S(105); -- Stage used in = 108
		PL_REG_305 <= A1(106, 2) and B1(106, 13); -- Stage used in = 108
		PL_REG_345 <= PL_REG_345(13 downto 0) & C(105); -- Stage used in = 122

		-- stage 108
		PL_REG_307 <= S(106); -- Stage used in = 109
		PL_REG_308 <= A1(107, 3) and B1(107, 12); -- Stage used in = 109
		PL_REG_349 <= PL_REG_349(13 downto 0) & C(106); -- Stage used in = 123

		-- stage 109
		PL_REG_310 <= S(107); -- Stage used in = 110
		PL_REG_311 <= A1(108, 4) and B1(108, 11); -- Stage used in = 110
		PL_REG_352 <= PL_REG_352(13 downto 0) & C(107); -- Stage used in = 124

		-- stage 110
		PL_REG_313 <= S(108); -- Stage used in = 111
		PL_REG_314 <= A1(109, 5) and B1(109, 10); -- Stage used in = 111
		PL_REG_355 <= PL_REG_355(13 downto 0) & C(108); -- Stage used in = 125

		-- stage 111
		PL_REG_316 <= S(109); -- Stage used in = 112
		PL_REG_317 <= A1(110, 6) and B1(110, 9); -- Stage used in = 112
		PL_REG_358 <= PL_REG_358(13 downto 0) & C(109); -- Stage used in = 126

		-- stage 112
		PL_REG_319 <= S(110); -- Stage used in = 113
		PL_REG_320 <= A1(111, 7) and B1(111, 8); -- Stage used in = 113
		PL_REG_361 <= PL_REG_361(13 downto 0) & C(110); -- Stage used in = 127

		-- stage 113
		PL_REG_322 <= S(111); -- Stage used in = 114
		PL_REG_323 <= A1(112, 8) and B1(112, 7); -- Stage used in = 114
		PL_REG_364 <= PL_REG_364(13 downto 0) & C(111); -- Stage used in = 128

		-- stage 114
		PL_REG_325 <= S(112); -- Stage used in = 115
		PL_REG_326 <= A1(113, 9) and B1(113, 6); -- Stage used in = 115
		PL_REG_367 <= PL_REG_367(13 downto 0) & C(112); -- Stage used in = 129

		-- stage 115
		PL_REG_328 <= S(113); -- Stage used in = 116
		PL_REG_329 <= A1(114, 10) and B1(114, 5); -- Stage used in = 116
		PL_REG_370 <= PL_REG_370(13 downto 0) & C(113); -- Stage used in = 130

		-- stage 116
		PL_REG_331 <= S(114); -- Stage used in = 117
		PL_REG_332 <= A1(115, 11) and B1(115, 4); -- Stage used in = 117
		PL_REG_373 <= PL_REG_373(13 downto 0) & C(114); -- Stage used in = 131

		-- stage 117
		PL_REG_334 <= S(115); -- Stage used in = 118
		PL_REG_335 <= A1(116, 12) and B1(116, 3); -- Stage used in = 118
		PL_REG_376 <= PL_REG_376(13 downto 0) & C(115); -- Stage used in = 132

		-- stage 118
		PL_REG_337 <= S(116); -- Stage used in = 119
		PL_REG_338 <= A1(117, 13) and B1(117, 2); -- Stage used in = 119
		PL_REG_379 <= PL_REG_379(13 downto 0) & C(116); -- Stage used in = 133

		-- stage 119
		PL_REG_340 <= S(117); -- Stage used in = 120
		PL_REG_341 <= A1(118, 14) and B1(118, 1); -- Stage used in = 120
		PL_REG_382 <= PL_REG_382(13 downto 0) & C(117); -- Stage used in = 134

		-- stage 120
		PL_REG_343 <= S(118); -- Stage used in = 121
		PL_REG_344 <= A1(119, 15) and B1(119, 0); -- Stage used in = 121
		PL_REG_385 <= PL_REG_385(13 downto 0) & C(118); -- Stage used in = 135

		-- stage 121
		Y15 <= Y15(119 downto 0) & S(119);
		PL_REG_346 <= A1(120, 1) and B1(120, 15); -- Stage used in = 122
		PL_REG_388 <= PL_REG_388(13 downto 0) & C(119); -- Stage used in = 136

		-- stage 122
		PL_REG_347 <= S(120); -- Stage used in = 123
		PL_REG_348 <= A1(121, 2) and B1(121, 14); -- Stage used in = 123
		PL_REG_389 <= PL_REG_389(13 downto 0) & C(120); -- Stage used in = 137

		-- stage 123
		PL_REG_350 <= S(121); -- Stage used in = 124
		PL_REG_351 <= A1(122, 3) and B1(122, 13); -- Stage used in = 124
		PL_REG_391 <= PL_REG_391(12 downto 0) & C(121); -- Stage used in = 137

		-- stage 124
		PL_REG_353 <= S(122); -- Stage used in = 125
		PL_REG_354 <= A1(123, 4) and B1(123, 12); -- Stage used in = 125
		PL_REG_394 <= PL_REG_394(12 downto 0) & C(122); -- Stage used in = 138

		-- stage 125
		PL_REG_356 <= S(123); -- Stage used in = 126
		PL_REG_357 <= A1(124, 5) and B1(124, 11); -- Stage used in = 126
		PL_REG_397 <= PL_REG_397(12 downto 0) & C(123); -- Stage used in = 139

		-- stage 126
		PL_REG_359 <= S(124); -- Stage used in = 127
		PL_REG_360 <= A1(125, 6) and B1(125, 10); -- Stage used in = 127
		PL_REG_400 <= PL_REG_400(12 downto 0) & C(124); -- Stage used in = 140

		-- stage 127
		PL_REG_362 <= S(125); -- Stage used in = 128
		PL_REG_363 <= A1(126, 7) and B1(126, 9); -- Stage used in = 128
		PL_REG_403 <= PL_REG_403(12 downto 0) & C(125); -- Stage used in = 141

		-- stage 128
		PL_REG_365 <= S(126); -- Stage used in = 129
		PL_REG_366 <= A1(127, 8) and B1(127, 8); -- Stage used in = 129
		PL_REG_406 <= PL_REG_406(12 downto 0) & C(126); -- Stage used in = 142

		-- stage 129
		PL_REG_368 <= S(127); -- Stage used in = 130
		PL_REG_369 <= A1(128, 9) and B1(128, 7); -- Stage used in = 130
		PL_REG_409 <= PL_REG_409(12 downto 0) & C(127); -- Stage used in = 143

		-- stage 130
		PL_REG_371 <= S(128); -- Stage used in = 131
		PL_REG_372 <= A1(129, 10) and B1(129, 6); -- Stage used in = 131
		PL_REG_412 <= PL_REG_412(12 downto 0) & C(128); -- Stage used in = 144

		-- stage 131
		PL_REG_374 <= S(129); -- Stage used in = 132
		PL_REG_375 <= A1(130, 11) and B1(130, 5); -- Stage used in = 132
		PL_REG_415 <= PL_REG_415(12 downto 0) & C(129); -- Stage used in = 145

		-- stage 132
		PL_REG_377 <= S(130); -- Stage used in = 133
		PL_REG_378 <= A1(131, 12) and B1(131, 4); -- Stage used in = 133
		PL_REG_418 <= PL_REG_418(12 downto 0) & C(130); -- Stage used in = 146

		-- stage 133
		PL_REG_380 <= S(131); -- Stage used in = 134
		PL_REG_381 <= A1(132, 13) and B1(132, 3); -- Stage used in = 134
		PL_REG_421 <= PL_REG_421(12 downto 0) & C(131); -- Stage used in = 147

		-- stage 134
		PL_REG_383 <= S(132); -- Stage used in = 135
		PL_REG_384 <= A1(133, 14) and B1(133, 2); -- Stage used in = 135
		PL_REG_424 <= PL_REG_424(12 downto 0) & C(132); -- Stage used in = 148

		-- stage 135
		PL_REG_386 <= S(133); -- Stage used in = 136
		PL_REG_387 <= A1(134, 15) and B1(134, 1); -- Stage used in = 136
		PL_REG_427 <= PL_REG_427(12 downto 0) & C(133); -- Stage used in = 149

		-- stage 136
		Y16 <= Y16(104 downto 0) & S(134);
		PL_REG_390 <= A1(135, 2) and B1(135, 15); -- Stage used in = 137
		PL_REG_430 <= PL_REG_430(12 downto 0) & C(134); -- Stage used in = 150

		-- stage 137
		PL_REG_392 <= S(135); -- Stage used in = 138
		PL_REG_393 <= A1(136, 3) and B1(136, 14); -- Stage used in = 138
		PL_REG_431 <= PL_REG_431(12 downto 0) & C(135); -- Stage used in = 151

		-- stage 138
		PL_REG_395 <= S(136); -- Stage used in = 139
		PL_REG_396 <= A1(137, 4) and B1(137, 13); -- Stage used in = 139
		PL_REG_433 <= PL_REG_433(11 downto 0) & C(136); -- Stage used in = 151

		-- stage 139
		PL_REG_398 <= S(137); -- Stage used in = 140
		PL_REG_399 <= A1(138, 5) and B1(138, 12); -- Stage used in = 140
		PL_REG_436 <= PL_REG_436(11 downto 0) & C(137); -- Stage used in = 152

		-- stage 140
		PL_REG_401 <= S(138); -- Stage used in = 141
		PL_REG_402 <= A1(139, 6) and B1(139, 11); -- Stage used in = 141
		PL_REG_439 <= PL_REG_439(11 downto 0) & C(138); -- Stage used in = 153

		-- stage 141
		PL_REG_404 <= S(139); -- Stage used in = 142
		PL_REG_405 <= A1(140, 7) and B1(140, 10); -- Stage used in = 142
		PL_REG_442 <= PL_REG_442(11 downto 0) & C(139); -- Stage used in = 154

		-- stage 142
		PL_REG_407 <= S(140); -- Stage used in = 143
		PL_REG_408 <= A1(141, 8) and B1(141, 9); -- Stage used in = 143
		PL_REG_445 <= PL_REG_445(11 downto 0) & C(140); -- Stage used in = 155

		-- stage 143
		PL_REG_410 <= S(141); -- Stage used in = 144
		PL_REG_411 <= A1(142, 9) and B1(142, 8); -- Stage used in = 144
		PL_REG_448 <= PL_REG_448(11 downto 0) & C(141); -- Stage used in = 156

		-- stage 144
		PL_REG_413 <= S(142); -- Stage used in = 145
		PL_REG_414 <= A1(143, 10) and B1(143, 7); -- Stage used in = 145
		PL_REG_451 <= PL_REG_451(11 downto 0) & C(142); -- Stage used in = 157

		-- stage 145
		PL_REG_416 <= S(143); -- Stage used in = 146
		PL_REG_417 <= A1(144, 11) and B1(144, 6); -- Stage used in = 146
		PL_REG_454 <= PL_REG_454(11 downto 0) & C(143); -- Stage used in = 158

		-- stage 146
		PL_REG_419 <= S(144); -- Stage used in = 147
		PL_REG_420 <= A1(145, 12) and B1(145, 5); -- Stage used in = 147
		PL_REG_457 <= PL_REG_457(11 downto 0) & C(144); -- Stage used in = 159

		-- stage 147
		PL_REG_422 <= S(145); -- Stage used in = 148
		PL_REG_423 <= A1(146, 13) and B1(146, 4); -- Stage used in = 148
		PL_REG_460 <= PL_REG_460(11 downto 0) & C(145); -- Stage used in = 160

		-- stage 148
		PL_REG_425 <= S(146); -- Stage used in = 149
		PL_REG_426 <= A1(147, 14) and B1(147, 3); -- Stage used in = 149
		PL_REG_463 <= PL_REG_463(11 downto 0) & C(146); -- Stage used in = 161

		-- stage 149
		PL_REG_428 <= S(147); -- Stage used in = 150
		PL_REG_429 <= A1(148, 15) and B1(148, 2); -- Stage used in = 150
		PL_REG_466 <= PL_REG_466(11 downto 0) & C(147); -- Stage used in = 162

		-- stage 150
		Y17 <= Y17(90 downto 0) & S(148);
		PL_REG_432 <= A1(149, 3) and B1(149, 15); -- Stage used in = 151
		PL_REG_469 <= PL_REG_469(11 downto 0) & C(148); -- Stage used in = 163

		-- stage 151
		PL_REG_434 <= S(149); -- Stage used in = 152
		PL_REG_435 <= A1(150, 4) and B1(150, 14); -- Stage used in = 152
		PL_REG_470 <= PL_REG_470(11 downto 0) & C(149); -- Stage used in = 164

		-- stage 152
		PL_REG_437 <= S(150); -- Stage used in = 153
		PL_REG_438 <= A1(151, 5) and B1(151, 13); -- Stage used in = 153
		PL_REG_472 <= PL_REG_472(10 downto 0) & C(150); -- Stage used in = 164

		-- stage 153
		PL_REG_440 <= S(151); -- Stage used in = 154
		PL_REG_441 <= A1(152, 6) and B1(152, 12); -- Stage used in = 154
		PL_REG_475 <= PL_REG_475(10 downto 0) & C(151); -- Stage used in = 165

		-- stage 154
		PL_REG_443 <= S(152); -- Stage used in = 155
		PL_REG_444 <= A1(153, 7) and B1(153, 11); -- Stage used in = 155
		PL_REG_478 <= PL_REG_478(10 downto 0) & C(152); -- Stage used in = 166

		-- stage 155
		PL_REG_446 <= S(153); -- Stage used in = 156
		PL_REG_447 <= A1(154, 8) and B1(154, 10); -- Stage used in = 156
		PL_REG_481 <= PL_REG_481(10 downto 0) & C(153); -- Stage used in = 167

		-- stage 156
		PL_REG_449 <= S(154); -- Stage used in = 157
		PL_REG_450 <= A1(155, 9) and B1(155, 9); -- Stage used in = 157
		PL_REG_484 <= PL_REG_484(10 downto 0) & C(154); -- Stage used in = 168

		-- stage 157
		PL_REG_452 <= S(155); -- Stage used in = 158
		PL_REG_453 <= A1(156, 10) and B1(156, 8); -- Stage used in = 158
		PL_REG_487 <= PL_REG_487(10 downto 0) & C(155); -- Stage used in = 169

		-- stage 158
		PL_REG_455 <= S(156); -- Stage used in = 159
		PL_REG_456 <= A1(157, 11) and B1(157, 7); -- Stage used in = 159
		PL_REG_490 <= PL_REG_490(10 downto 0) & C(156); -- Stage used in = 170

		-- stage 159
		PL_REG_458 <= S(157); -- Stage used in = 160
		PL_REG_459 <= A1(158, 12) and B1(158, 6); -- Stage used in = 160
		PL_REG_493 <= PL_REG_493(10 downto 0) & C(157); -- Stage used in = 171

		-- stage 160
		PL_REG_461 <= S(158); -- Stage used in = 161
		PL_REG_462 <= A1(159, 13) and B1(159, 5); -- Stage used in = 161
		PL_REG_496 <= PL_REG_496(10 downto 0) & C(158); -- Stage used in = 172

		-- stage 161
		PL_REG_464 <= S(159); -- Stage used in = 162
		PL_REG_465 <= A1(160, 14) and B1(160, 4); -- Stage used in = 162
		PL_REG_499 <= PL_REG_499(10 downto 0) & C(159); -- Stage used in = 173

		-- stage 162
		PL_REG_467 <= S(160); -- Stage used in = 163
		PL_REG_468 <= A1(161, 15) and B1(161, 3); -- Stage used in = 163
		PL_REG_502 <= PL_REG_502(10 downto 0) & C(160); -- Stage used in = 174

		-- stage 163
		Y18 <= Y18(77 downto 0) & S(161);
		PL_REG_471 <= A1(162, 4) and B1(162, 15); -- Stage used in = 164
		PL_REG_505 <= PL_REG_505(10 downto 0) & C(161); -- Stage used in = 175

		-- stage 164
		PL_REG_473 <= S(162); -- Stage used in = 165
		PL_REG_474 <= A1(163, 5) and B1(163, 14); -- Stage used in = 165
		PL_REG_506 <= PL_REG_506(10 downto 0) & C(162); -- Stage used in = 176

		-- stage 165
		PL_REG_476 <= S(163); -- Stage used in = 166
		PL_REG_477 <= A1(164, 6) and B1(164, 13); -- Stage used in = 166
		PL_REG_508 <= PL_REG_508(9 downto 0) & C(163); -- Stage used in = 176

		-- stage 166
		PL_REG_479 <= S(164); -- Stage used in = 167
		PL_REG_480 <= A1(165, 7) and B1(165, 12); -- Stage used in = 167
		PL_REG_511 <= PL_REG_511(9 downto 0) & C(164); -- Stage used in = 177

		-- stage 167
		PL_REG_482 <= S(165); -- Stage used in = 168
		PL_REG_483 <= A1(166, 8) and B1(166, 11); -- Stage used in = 168
		PL_REG_514 <= PL_REG_514(9 downto 0) & C(165); -- Stage used in = 178

		-- stage 168
		PL_REG_485 <= S(166); -- Stage used in = 169
		PL_REG_486 <= A1(167, 9) and B1(167, 10); -- Stage used in = 169
		PL_REG_517 <= PL_REG_517(9 downto 0) & C(166); -- Stage used in = 179

		-- stage 169
		PL_REG_488 <= S(167); -- Stage used in = 170
		PL_REG_489 <= A1(168, 10) and B1(168, 9); -- Stage used in = 170
		PL_REG_520 <= PL_REG_520(9 downto 0) & C(167); -- Stage used in = 180

		-- stage 170
		PL_REG_491 <= S(168); -- Stage used in = 171
		PL_REG_492 <= A1(169, 11) and B1(169, 8); -- Stage used in = 171
		PL_REG_523 <= PL_REG_523(9 downto 0) & C(168); -- Stage used in = 181

		-- stage 171
		PL_REG_494 <= S(169); -- Stage used in = 172
		PL_REG_495 <= A1(170, 12) and B1(170, 7); -- Stage used in = 172
		PL_REG_526 <= PL_REG_526(9 downto 0) & C(169); -- Stage used in = 182

		-- stage 172
		PL_REG_497 <= S(170); -- Stage used in = 173
		PL_REG_498 <= A1(171, 13) and B1(171, 6); -- Stage used in = 173
		PL_REG_529 <= PL_REG_529(9 downto 0) & C(170); -- Stage used in = 183

		-- stage 173
		PL_REG_500 <= S(171); -- Stage used in = 174
		PL_REG_501 <= A1(172, 14) and B1(172, 5); -- Stage used in = 174
		PL_REG_532 <= PL_REG_532(9 downto 0) & C(171); -- Stage used in = 184

		-- stage 174
		PL_REG_503 <= S(172); -- Stage used in = 175
		PL_REG_504 <= A1(173, 15) and B1(173, 4); -- Stage used in = 175
		PL_REG_535 <= PL_REG_535(9 downto 0) & C(172); -- Stage used in = 185

		-- stage 175
		Y19 <= Y19(65 downto 0) & S(173);
		PL_REG_507 <= A1(174, 5) and B1(174, 15); -- Stage used in = 176
		PL_REG_538 <= PL_REG_538(9 downto 0) & C(173); -- Stage used in = 186

		-- stage 176
		PL_REG_509 <= S(174); -- Stage used in = 177
		PL_REG_510 <= A1(175, 6) and B1(175, 14); -- Stage used in = 177
		PL_REG_539 <= PL_REG_539(9 downto 0) & C(174); -- Stage used in = 187

		-- stage 177
		PL_REG_512 <= S(175); -- Stage used in = 178
		PL_REG_513 <= A1(176, 7) and B1(176, 13); -- Stage used in = 178
		PL_REG_541 <= PL_REG_541(8 downto 0) & C(175); -- Stage used in = 187

		-- stage 178
		PL_REG_515 <= S(176); -- Stage used in = 179
		PL_REG_516 <= A1(177, 8) and B1(177, 12); -- Stage used in = 179
		PL_REG_544 <= PL_REG_544(8 downto 0) & C(176); -- Stage used in = 188

		-- stage 179
		PL_REG_518 <= S(177); -- Stage used in = 180
		PL_REG_519 <= A1(178, 9) and B1(178, 11); -- Stage used in = 180
		PL_REG_547 <= PL_REG_547(8 downto 0) & C(177); -- Stage used in = 189

		-- stage 180
		PL_REG_521 <= S(178); -- Stage used in = 181
		PL_REG_522 <= A1(179, 10) and B1(179, 10); -- Stage used in = 181
		PL_REG_550 <= PL_REG_550(8 downto 0) & C(178); -- Stage used in = 190

		-- stage 181
		PL_REG_524 <= S(179); -- Stage used in = 182
		PL_REG_525 <= A1(180, 11) and B1(180, 9); -- Stage used in = 182
		PL_REG_553 <= PL_REG_553(8 downto 0) & C(179); -- Stage used in = 191

		-- stage 182
		PL_REG_527 <= S(180); -- Stage used in = 183
		PL_REG_528 <= A1(181, 12) and B1(181, 8); -- Stage used in = 183
		PL_REG_556 <= PL_REG_556(8 downto 0) & C(180); -- Stage used in = 192

		-- stage 183
		PL_REG_530 <= S(181); -- Stage used in = 184
		PL_REG_531 <= A1(182, 13) and B1(182, 7); -- Stage used in = 184
		PL_REG_559 <= PL_REG_559(8 downto 0) & C(181); -- Stage used in = 193

		-- stage 184
		PL_REG_533 <= S(182); -- Stage used in = 185
		PL_REG_534 <= A1(183, 14) and B1(183, 6); -- Stage used in = 185
		PL_REG_562 <= PL_REG_562(8 downto 0) & C(182); -- Stage used in = 194

		-- stage 185
		PL_REG_536 <= S(183); -- Stage used in = 186
		PL_REG_537 <= A1(184, 15) and B1(184, 5); -- Stage used in = 186
		PL_REG_565 <= PL_REG_565(8 downto 0) & C(183); -- Stage used in = 195

		-- stage 186
		Y20 <= Y20(54 downto 0) & S(184);
		PL_REG_540 <= A1(185, 6) and B1(185, 15); -- Stage used in = 187
		PL_REG_568 <= PL_REG_568(8 downto 0) & C(184); -- Stage used in = 196

		-- stage 187
		PL_REG_542 <= S(185); -- Stage used in = 188
		PL_REG_543 <= A1(186, 7) and B1(186, 14); -- Stage used in = 188
		PL_REG_569 <= PL_REG_569(8 downto 0) & C(185); -- Stage used in = 197

		-- stage 188
		PL_REG_545 <= S(186); -- Stage used in = 189
		PL_REG_546 <= A1(187, 8) and B1(187, 13); -- Stage used in = 189
		PL_REG_571 <= PL_REG_571(7 downto 0) & C(186); -- Stage used in = 197

		-- stage 189
		PL_REG_548 <= S(187); -- Stage used in = 190
		PL_REG_549 <= A1(188, 9) and B1(188, 12); -- Stage used in = 190
		PL_REG_574 <= PL_REG_574(7 downto 0) & C(187); -- Stage used in = 198

		-- stage 190
		PL_REG_551 <= S(188); -- Stage used in = 191
		PL_REG_552 <= A1(189, 10) and B1(189, 11); -- Stage used in = 191
		PL_REG_577 <= PL_REG_577(7 downto 0) & C(188); -- Stage used in = 199

		-- stage 191
		PL_REG_554 <= S(189); -- Stage used in = 192
		PL_REG_555 <= A1(190, 11) and B1(190, 10); -- Stage used in = 192
		PL_REG_580 <= PL_REG_580(7 downto 0) & C(189); -- Stage used in = 200

		-- stage 192
		PL_REG_557 <= S(190); -- Stage used in = 193
		PL_REG_558 <= A1(191, 12) and B1(191, 9); -- Stage used in = 193
		PL_REG_583 <= PL_REG_583(7 downto 0) & C(190); -- Stage used in = 201

		-- stage 193
		PL_REG_560 <= S(191); -- Stage used in = 194
		PL_REG_561 <= A1(192, 13) and B1(192, 8); -- Stage used in = 194
		PL_REG_586 <= PL_REG_586(7 downto 0) & C(191); -- Stage used in = 202

		-- stage 194
		PL_REG_563 <= S(192); -- Stage used in = 195
		PL_REG_564 <= A1(193, 14) and B1(193, 7); -- Stage used in = 195
		PL_REG_589 <= PL_REG_589(7 downto 0) & C(192); -- Stage used in = 203

		-- stage 195
		PL_REG_566 <= S(193); -- Stage used in = 196
		PL_REG_567 <= A1(194, 15) and B1(194, 6); -- Stage used in = 196
		PL_REG_592 <= PL_REG_592(7 downto 0) & C(193); -- Stage used in = 204

		-- stage 196
		Y21 <= Y21(44 downto 0) & S(194);
		PL_REG_570 <= A1(195, 7) and B1(195, 15); -- Stage used in = 197
		PL_REG_595 <= PL_REG_595(7 downto 0) & C(194); -- Stage used in = 205

		-- stage 197
		PL_REG_572 <= S(195); -- Stage used in = 198
		PL_REG_573 <= A1(196, 8) and B1(196, 14); -- Stage used in = 198
		PL_REG_596 <= PL_REG_596(7 downto 0) & C(195); -- Stage used in = 206

		-- stage 198
		PL_REG_575 <= S(196); -- Stage used in = 199
		PL_REG_576 <= A1(197, 9) and B1(197, 13); -- Stage used in = 199
		PL_REG_598 <= PL_REG_598(6 downto 0) & C(196); -- Stage used in = 206

		-- stage 199
		PL_REG_578 <= S(197); -- Stage used in = 200
		PL_REG_579 <= A1(198, 10) and B1(198, 12); -- Stage used in = 200
		PL_REG_601 <= PL_REG_601(6 downto 0) & C(197); -- Stage used in = 207

		-- stage 200
		PL_REG_581 <= S(198); -- Stage used in = 201
		PL_REG_582 <= A1(199, 11) and B1(199, 11); -- Stage used in = 201
		PL_REG_604 <= PL_REG_604(6 downto 0) & C(198); -- Stage used in = 208

		-- stage 201
		PL_REG_584 <= S(199); -- Stage used in = 202
		PL_REG_585 <= A1(200, 12) and B1(200, 10); -- Stage used in = 202
		PL_REG_607 <= PL_REG_607(6 downto 0) & C(199); -- Stage used in = 209

		-- stage 202
		PL_REG_587 <= S(200); -- Stage used in = 203
		PL_REG_588 <= A1(201, 13) and B1(201, 9); -- Stage used in = 203
		PL_REG_610 <= PL_REG_610(6 downto 0) & C(200); -- Stage used in = 210

		-- stage 203
		PL_REG_590 <= S(201); -- Stage used in = 204
		PL_REG_591 <= A1(202, 14) and B1(202, 8); -- Stage used in = 204
		PL_REG_613 <= PL_REG_613(6 downto 0) & C(201); -- Stage used in = 211

		-- stage 204
		PL_REG_593 <= S(202); -- Stage used in = 205
		PL_REG_594 <= A1(203, 15) and B1(203, 7); -- Stage used in = 205
		PL_REG_616 <= PL_REG_616(6 downto 0) & C(202); -- Stage used in = 212

		-- stage 205
		Y22 <= Y22(35 downto 0) & S(203);
		PL_REG_597 <= A1(204, 8) and B1(204, 15); -- Stage used in = 206
		PL_REG_619 <= PL_REG_619(6 downto 0) & C(203); -- Stage used in = 213

		-- stage 206
		PL_REG_599 <= S(204); -- Stage used in = 207
		PL_REG_600 <= A1(205, 9) and B1(205, 14); -- Stage used in = 207
		PL_REG_620 <= PL_REG_620(6 downto 0) & C(204); -- Stage used in = 214

		-- stage 207
		PL_REG_602 <= S(205); -- Stage used in = 208
		PL_REG_603 <= A1(206, 10) and B1(206, 13); -- Stage used in = 208
		PL_REG_622 <= PL_REG_622(5 downto 0) & C(205); -- Stage used in = 214

		-- stage 208
		PL_REG_605 <= S(206); -- Stage used in = 209
		PL_REG_606 <= A1(207, 11) and B1(207, 12); -- Stage used in = 209
		PL_REG_625 <= PL_REG_625(5 downto 0) & C(206); -- Stage used in = 215

		-- stage 209
		PL_REG_608 <= S(207); -- Stage used in = 210
		PL_REG_609 <= A1(208, 12) and B1(208, 11); -- Stage used in = 210
		PL_REG_628 <= PL_REG_628(5 downto 0) & C(207); -- Stage used in = 216

		-- stage 210
		PL_REG_611 <= S(208); -- Stage used in = 211
		PL_REG_612 <= A1(209, 13) and B1(209, 10); -- Stage used in = 211
		PL_REG_631 <= PL_REG_631(5 downto 0) & C(208); -- Stage used in = 217

		-- stage 211
		PL_REG_614 <= S(209); -- Stage used in = 212
		PL_REG_615 <= A1(210, 14) and B1(210, 9); -- Stage used in = 212
		PL_REG_634 <= PL_REG_634(5 downto 0) & C(209); -- Stage used in = 218

		-- stage 212
		PL_REG_617 <= S(210); -- Stage used in = 213
		PL_REG_618 <= A1(211, 15) and B1(211, 8); -- Stage used in = 213
		PL_REG_637 <= PL_REG_637(5 downto 0) & C(210); -- Stage used in = 219

		-- stage 213
		Y23 <= Y23(27 downto 0) & S(211);
		PL_REG_621 <= A1(212, 9) and B1(212, 15); -- Stage used in = 214
		PL_REG_640 <= PL_REG_640(5 downto 0) & C(211); -- Stage used in = 220

		-- stage 214
		PL_REG_623 <= S(212); -- Stage used in = 215
		PL_REG_624 <= A1(213, 10) and B1(213, 14); -- Stage used in = 215
		PL_REG_641 <= PL_REG_641(5 downto 0) & C(212); -- Stage used in = 221

		-- stage 215
		PL_REG_626 <= S(213); -- Stage used in = 216
		PL_REG_627 <= A1(214, 11) and B1(214, 13); -- Stage used in = 216
		PL_REG_643 <= PL_REG_643(4 downto 0) & C(213); -- Stage used in = 221

		-- stage 216
		PL_REG_629 <= S(214); -- Stage used in = 217
		PL_REG_630 <= A1(215, 12) and B1(215, 12); -- Stage used in = 217
		PL_REG_646 <= PL_REG_646(4 downto 0) & C(214); -- Stage used in = 222

		-- stage 217
		PL_REG_632 <= S(215); -- Stage used in = 218
		PL_REG_633 <= A1(216, 13) and B1(216, 11); -- Stage used in = 218
		PL_REG_649 <= PL_REG_649(4 downto 0) & C(215); -- Stage used in = 223

		-- stage 218
		PL_REG_635 <= S(216); -- Stage used in = 219
		PL_REG_636 <= A1(217, 14) and B1(217, 10); -- Stage used in = 219
		PL_REG_652 <= PL_REG_652(4 downto 0) & C(216); -- Stage used in = 224

		-- stage 219
		PL_REG_638 <= S(217); -- Stage used in = 220
		PL_REG_639 <= A1(218, 15) and B1(218, 9); -- Stage used in = 220
		PL_REG_655 <= PL_REG_655(4 downto 0) & C(217); -- Stage used in = 225

		-- stage 220
		Y24 <= Y24(20 downto 0) & S(218);
		PL_REG_642 <= A1(219, 10) and B1(219, 15); -- Stage used in = 221
		PL_REG_658 <= PL_REG_658(4 downto 0) & C(218); -- Stage used in = 226

		-- stage 221
		PL_REG_644 <= S(219); -- Stage used in = 222
		PL_REG_645 <= A1(220, 11) and B1(220, 14); -- Stage used in = 222
		PL_REG_659 <= PL_REG_659(4 downto 0) & C(219); -- Stage used in = 227

		-- stage 222
		PL_REG_647 <= S(220); -- Stage used in = 223
		PL_REG_648 <= A1(221, 12) and B1(221, 13); -- Stage used in = 223
		PL_REG_661 <= PL_REG_661(3 downto 0) & C(220); -- Stage used in = 227

		-- stage 223
		PL_REG_650 <= S(221); -- Stage used in = 224
		PL_REG_651 <= A1(222, 13) and B1(222, 12); -- Stage used in = 224
		PL_REG_664 <= PL_REG_664(3 downto 0) & C(221); -- Stage used in = 228

		-- stage 224
		PL_REG_653 <= S(222); -- Stage used in = 225
		PL_REG_654 <= A1(223, 14) and B1(223, 11); -- Stage used in = 225
		PL_REG_667 <= PL_REG_667(3 downto 0) & C(222); -- Stage used in = 229

		-- stage 225
		PL_REG_656 <= S(223); -- Stage used in = 226
		PL_REG_657 <= A1(224, 15) and B1(224, 10); -- Stage used in = 226
		PL_REG_670 <= PL_REG_670(3 downto 0) & C(223); -- Stage used in = 230

		-- stage 226
		Y25 <= Y25(14 downto 0) & S(224);
		PL_REG_660 <= A1(225, 11) and B1(225, 15); -- Stage used in = 227
		PL_REG_673 <= PL_REG_673(3 downto 0) & C(224); -- Stage used in = 231

		-- stage 227
		PL_REG_662 <= S(225); -- Stage used in = 228
		PL_REG_663 <= A1(226, 12) and B1(226, 14); -- Stage used in = 228
		PL_REG_674 <= PL_REG_674(3 downto 0) & C(225); -- Stage used in = 232

		-- stage 228
		PL_REG_665 <= S(226); -- Stage used in = 229
		PL_REG_666 <= A1(227, 13) and B1(227, 13); -- Stage used in = 229
		PL_REG_676 <= PL_REG_676(2 downto 0) & C(226); -- Stage used in = 232

		-- stage 229
		PL_REG_668 <= S(227); -- Stage used in = 230
		PL_REG_669 <= A1(228, 14) and B1(228, 12); -- Stage used in = 230
		PL_REG_679 <= PL_REG_679(2 downto 0) & C(227); -- Stage used in = 233

		-- stage 230
		PL_REG_671 <= S(228); -- Stage used in = 231
		PL_REG_672 <= A1(229, 15) and B1(229, 11); -- Stage used in = 231
		PL_REG_682 <= PL_REG_682(2 downto 0) & C(228); -- Stage used in = 234

		-- stage 231
		Y26 <= Y26(9 downto 0) & S(229);
		PL_REG_675 <= A1(230, 12) and B1(230, 15); -- Stage used in = 232
		PL_REG_685 <= PL_REG_685(2 downto 0) & C(229); -- Stage used in = 235

		-- stage 232
		PL_REG_677 <= S(230); -- Stage used in = 233
		PL_REG_678 <= A1(231, 13) and B1(231, 14); -- Stage used in = 233
		PL_REG_686 <= PL_REG_686(2 downto 0) & C(230); -- Stage used in = 236

		-- stage 233
		PL_REG_680 <= S(231); -- Stage used in = 234
		PL_REG_681 <= A1(232, 14) and B1(232, 13); -- Stage used in = 234
		PL_REG_688 <= PL_REG_688(1 downto 0) & C(231); -- Stage used in = 236

		-- stage 234
		PL_REG_683 <= S(232); -- Stage used in = 235
		PL_REG_684 <= A1(233, 15) and B1(233, 12); -- Stage used in = 235
		PL_REG_691 <= PL_REG_691(1 downto 0) & C(232); -- Stage used in = 237

		-- stage 235
		Y27 <= Y27(5 downto 0) & S(233);
		PL_REG_687 <= A1(234, 13) and B1(234, 15); -- Stage used in = 236
		PL_REG_694 <= PL_REG_694(1 downto 0) & C(233); -- Stage used in = 238

		-- stage 236
		PL_REG_689 <= S(234); -- Stage used in = 237
		PL_REG_690 <= A1(235, 14) and B1(235, 14); -- Stage used in = 237
		PL_REG_695 <= PL_REG_695(1 downto 0) & C(234); -- Stage used in = 239

		-- stage 237
		PL_REG_692 <= S(235); -- Stage used in = 238
		PL_REG_693 <= A1(236, 15) and B1(236, 13); -- Stage used in = 238
		PL_REG_697 <= PL_REG_697(0 downto 0) & C(235); -- Stage used in = 239

		-- stage 238
		Y28 <= Y28(2 downto 0) & S(236);
		PL_REG_696 <= A1(237, 14) and B1(237, 15); -- Stage used in = 239
		PL_REG_700 <= PL_REG_700(0 downto 0) & C(236); -- Stage used in = 240

		-- stage 239
		PL_REG_698 <= S(237); -- Stage used in = 240
		PL_REG_699 <= A1(238, 15) and B1(238, 14); -- Stage used in = 240
		PL_REG_701 <= PL_REG_701(0 downto 0) & C(237); -- Stage used in = 241

		-- stage 240
		Y29 <= Y29(0 downto 0) & S(238);
		PL_REG_702 <= A1(239, 15) and B1(239, 15); -- Stage used in = 241
		PL_REG_703 <= C(238); -- Stage used in = 241

		-- stage 241
		Y30 <= S(239);
		Y31 <= C(239);

    end if;
  end process;
  
	Y(0) <= Y0(239);
	Y(1) <= Y1(239);
	Y(2) <= Y2(237);
	Y(3) <= Y3(234);
	Y(4) <= Y4(230);
	Y(5) <= Y5(225);
	Y(6) <= Y6(219);
	Y(7) <= Y7(212);
	Y(8) <= Y8(204);
	Y(9) <= Y9(195);
	Y(10) <= Y10(185);
	Y(11) <= Y11(174);
	Y(12) <= Y12(162);
	Y(13) <= Y13(149);
	Y(14) <= Y14(135);
	Y(15) <= Y15(120);
	Y(16) <= Y16(105);
	Y(17) <= Y17(91);
	Y(18) <= Y18(78);
	Y(19) <= Y19(66);
	Y(20) <= Y20(55);
	Y(21) <= Y21(45);
	Y(22) <= Y22(36);
	Y(23) <= Y23(28);
	Y(24) <= Y24(21);
	Y(25) <= Y25(15);
	Y(26) <= Y26(10);
	Y(27) <= Y27(6);
	Y(28) <= Y28(3);
	Y(29) <= Y29(1);
	Y(30) <= Y30;
	Y(31) <= Y31;

  Y_valid <= valid(241);  -- Asserted when output is valid
end Structural;
