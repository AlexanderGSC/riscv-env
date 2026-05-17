## RISC-V Vector Development Environment
Docker-based reproducible environment for experimenting with the RISC-V Vector Extension (RVV 1.0), including cross-compilation, emulation and hardware validation workflows.
The project is designed as a practical RVV laboratory for developing and benchmarking vectorized kernels in C, C++, Fortran and Rust using both QEMU emulation and real RISC-V vector hardware (Banana Pi BPI-F3 / SpacemiT K1).

### Environment Capabilities
* RVV 1.0 cross-compilation environment
* GCC 13.3 riscv64 toolchain
* QEMU RVV emulation support
* Support for RVV intrinsics and auto-vectorization
* Docker-based reproducible workflow
* Performance validation on physical RVV hardware (Banana Pi BPI-F3)

### How to Use
If you have Docker installed, simply clone the repository or the Dockerfile and run 
```bash
docker build . -t rvv
```
and start environmet
```bash
docker run -it --rm -v $(pwd):/app rvv
```
```text
=========================================
   RISC-V DEVELOPMENT ENVIRONMENT
=========================================
# C Compiler (Bare-metal):
riscv64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0
# C++ Compiler (Bare-metal):
riscv64-linux-gnu-g++ (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0
# QEMU User Mode:
qemu-riscv64 version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.16)
# Rust Compiler:
rustc 1.95.0 (59807616e 2026-04-14)
# Rust Targets:
riscv64gc-unknown-linux-gnu
=========================================
```

### Real Hardware Validation (BPI-F3)
As part of the PERTE Chip training program, this environment supports execution and benchmarking on physical RISC-V vector hardware:
* SpacemiT K1 based Open source SBC 
* Full RVV 1.0 Extension Support
* RISC-V SpacemiT® X60™ Dual-cluster Octa-core processors
* Adhere to the RISC-V 64GCVB architecture and RVA22 standard
* [Banana BPI-F3 Datasheet](https://docs.banana-pi.org/en/BPI-F3/SpacemiT_K1_datasheet)
### Example Benchmark Workflow
1. Compile kernel
```bash
riscv64-linux-gnu-g++ -march=rv64gcv -mabi=lp64d -O3 main.cpp -o main
```

2. Verify vectorization output:
```Bash
riscv64-linux-gnu-objdump -d ./main | grep -E "vset|vle|vse|vadd|vfadd"
```
3. 3. Run on QEMU for functional validation or on real hardware (BPI-F3)
4. Use ```perf``` for performance analysis and results

Example on axpy kernel **size=1024*1024**: 

| Performance Metric | Scalar Version | Vectorized Version(m8) | Speedup |
| :--- | :---: | :---: | :---: |
| **Kernel Runtime** | 69.11 ms | **7.58 ms** | **9.11x** |
| **Total Time (Process)** | 175.86 ms | 75.35 ms | **2.33x** |
| **Total Instructions** | 184.25 M | **54.02 M** | **-70.6%** |
| **CPU Cycles** | 276.99 M | **114.82 M** | **-58.5%** |
| **IPC (Instructions Per Cycle)** | **0.67** | 0.47 | **-** |
| **L1-dcache Loads** | 59.99 M | **23.57 M** | **-60.7%** |
| **L1-dcache Miss Rate** | 0.17% | 0.42% | **Stable** |

### Engineering Goals
* Understand RVV 1.0 execution model in practice
* Analyze differences between emulated and real vector hardware
* Evaluate compiler behavior vs manual vectorization
* Build intuition for SIMD performance bottlenecks

  ### Context
This project is developed within the PERTE Chip training program, focusing on:
* RISC-V architecture
* Vector processing (RVV 1.0)
* Hardware/software co-design
* Performance-oriented systems programming
