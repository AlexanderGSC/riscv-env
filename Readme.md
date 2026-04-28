R## RISC-V Vector Development Environment (RVV 1.0 Lab)
Docker-based development environment for RISC-V Vector Extension (RVV 1.0) experimentation, enabling reproducible workflows for SIMD optimization, compiler analysis, and low-level performance evaluation.
This environment is part of the PERTE Chip training program, with access to real RISC-V vector hardware (Banana Pi BPI-F3) for performance validation beyond emulation.
### 🔥 Key Highlights
Ready-to-use RVV 1.0 development environment
Cross-compilation toolchain for riscv64 (GCC 13.3)
QEMU with vector support (VLEN=128 configurable)
Support for auto-vectorization and RVV intrinsics
Reproducible Docker environment (~860MB compressed)
Integration with real hardware benchmarking (BPI-F3)
### 🎯 Objective
This project is designed as a practical RVV performance laboratory, enabling:
Development of vectorized C++ and Rust kernels
Comparison of:
scalar execution
compiler auto-vectorization
manual RVV intrinsics
Validation of results on:
QEMU emulation
real RISC-V vector hardware (Banana Pi BPI-F3)
### 🧪 Real Hardware Validation (BPI-F3)
As part of the PERTE Chip training program, this environment supports execution and benchmarking on physical RISC-V vector hardware:
### 📌 Banana Pi BPI-F3
RISC-V architecture with RVV 1.0 support
Used to validate performance beyond emulation
Enables real measurement of:
execution time
vector utilization
memory bandwidth effects
### 📊 Example Benchmark Workflow
1. Compile kernel
Bash
riscv64-linux-gnu-g++ -march=rv64gcv -mabi=lp64d -O3 main.cpp -o main
2. Run on QEMU (emulation)
Bash
qv ./main
3. Run on real hardware (BPI-F3)
Bash
./main
Measure:
execution time (wall clock)
vector instruction efficiency
scaling behavior
### 🔍 Instruction Inspection
Verify vectorization output:
Bash
riscv64-linux-gnu-objdump -d ./main | grep -E "vset|vle|vse|vadd|vfadd"
### 📈 Performance Analysis (Real Hardware + Emulation)
This environment is designed to compare:
QEMU RVV emulation results
Real hardware execution (BPI-F3):

| Métrica de Rendimiento | Versión Escalar | Versión Vectorial (m8) | Mejora (Speedup) |
| :--- | :---: | :---: | :---: |
| **Tiempo de Cálculo (Kernel)** | 69.11 ms | **7.58 ms** | **9.11x** 🚀 |
| **Tiempo Total (Proceso)** | 175.86 ms | 75.35 ms | **2.33x** |
| **Instrucciones Totales** | 184.25 M | **54.02 M** | **-70.6%** |
| **Ciclos de CPU** | 276.99 M | **114.82 M** | **-58.5%** |
| **IPC (Instructions Per Cycle)** | **0.67** | 0.47 | (Nota 1) |
| **Cargas L1-dcache** | 59.99 M | **23.57 M** | **-60.7%** |
| **L1-dcache Miss Rate** | 0.17% | 0.42% | Estable |

vector length scaling effects
### 🧠 Engineering Goals
Understand RVV 1.0 execution model in practice
Analyze differences between emulated and real vector hardware
Evaluate compiler behavior vs manual vectorization
Build intuition for SIMD performance bottlenecks
🛠️ Environment Overview
### Plain text
C/C++ Compiler: GCC 13.3 (riscv64-linux-gnu)
Rust Compiler: 1.94 (riscv64gc target)
Emulation: QEMU 8.2 with RVV support
Hardware Target: Banana Pi BPI-F3 (RVV 1.0)
Vector Configuration: VLEN=128 (configurable)
### 🧪 Use Case Examples
Vector dot product benchmarking
SAXPY and AXPY kernels
Reduction operations (sum, max)
Memory-bound vs compute-bound analysis
### 📁 Structure
Plain text
srx/     → RVV kernels (C++ / C// ASM)
benchmarks/   → performance tests
scripts/      → build & run automation
results/      → measurement outputs
### 🚀 Future Work
Automated benchmark suite (QEMU vs BPI-F3 comparison)
Advanced RVV kernels (matrix multiply, convolution)
Integration with HPC-style profiling tools
Extended vector length experiments (VLEN scaling study)
### 🧭 Context
This project is developed within the PERTE Chip training program, focusing on:
RISC-V architecture
Vector processing (RVV 1.0)
Hardware/software co-design
Performance-oriented systems programming