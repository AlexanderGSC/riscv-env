#include <chrono>
#include <iostream>
#include <vector>
#include <riscv_vector.h>

constexpr size_t N = 1024 * 1024;


alignas(32) std::vector<float> a(N);
alignas(32) std::vector<float> b(N);
alignas(32) std::vector<float> c(N);

int main() {
    std::cout << "Elements processed with VV: " << __riscv_vsetvl_e32m8(N) << std::endl;
    // 1. Inicialización
    for (size_t i = 0; i < N; ) {
        size_t vl = __riscv_vsetvl_e32m8(N - i);
        auto v_indices = __riscv_vid_v_u32m8(vl);
        auto  va = __riscv_vfcvt_f_xu_v_f32m8(v_indices, vl);
        va = __riscv_vfadd_vf_f32m8(va, (float)i, vl);
        __riscv_vse32_v_f32m8(&a[i], va, vl);
        auto vb = __riscv_vfmul_vf_f32m8(va, 2.0f, vl);
        __riscv_vse32_v_f32m8(&b[i], vb, vl);
        i += vl;
    }
    
    // 2. Proceso Vectorial con cronómetro
    auto start = std::chrono::high_resolution_clock::now();

    for (size_t i = 0; i < N; ) {
        size_t vl = __riscv_vsetvl_e32m8(N - i);
        auto va = __riscv_vle32_v_f32m8(&a[i], vl);
        auto vb = __riscv_vle32_v_f32m8(&b[i], vl);
        auto vc = __riscv_vfadd_vv_f32m8(va, vb, vl);
        __riscv_vse32_v_f32m8(&c[i], vc, vl);
        i += vl;
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double, std::milli> diff = end - start;

    // 3. Comprobación rápida y tiempo
    std::cout << "Time (vectorial): " << diff.count() << " ms" << std::endl;
}