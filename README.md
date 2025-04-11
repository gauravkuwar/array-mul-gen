# Deeply Pipelined NxN-bit Array Multiplier Generator (VHDL)

- Using Python Generates VHDL Code for unsigned NxN bit multiplication for N > 1
- Generates entity file and testbench file (tests all combinations of multiplications).
- **Deeply pipelined** - one pipeline stage per adder level
- **Fully structural design** using half and full adders and no DSP usage.
- Tested and verified design on ModelSim for 2x2, 4x4, 8x8. (Rest of the designed are too big for free addition).
- Additional script for generating code for non-pipelined (fully combinational) NxN bit array multiplier.


## Results

| Bit Width | Non-Pipelined Freq (MHz) | Pipelined Freq (MHz) |
|-----------|---------------------------|------------------------------|
| 4×4       | 89.40                     | 145.29                       |
| 8×8       | 58.14                     | 127.50                       |
| 16×16     | —                         | 129.89                       |
| 32×32     | 17.15                     | 84.28                        |
| 64×64     | 6.23                      | 84.50                        |
| 128×128   | 2.89                      | —                            |


## Usage
Pipelined:
```bash
python main.py --bits <N>
```

Non-pipelined:
```bash
python non_pl_mul_array.py --bits <N>
```

## Tools used
- **Python** – For generating parameterized VHDL and testbenches
- **ModelSim** – To simulate and verify functionality
- **Intel Quartus Prime** – For synthesis and frequency analysis