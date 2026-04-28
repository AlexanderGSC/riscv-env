#include <chrono>
#include <iostream>
#include <vector>
#include <riscv_vector.h>

constexpr size_t N = 1024 * 1024;

// Los movemos fuera para no reventar el stack
alignas(32)std::vector<float> a(N);
alignas(32) std::vector<float> b(N);
alignas(32) std::vector<float> c(N);

int main() {
    for (size_t i = 0; i < N; ++i) {
        a[i] = static_cast<float>(i);
        b[i] = static_cast<float>(i * 2);
    }
    
    auto start = std::chrono::high_resolution_clock::now();
    for (auto i=0; i<N; ++i) {
        c[i] = a[i] + b[i];
    }
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double, std::milli> diff = end - start;
    std::cout << "Time (scalar): " << diff.count() << " ms" << std::endl;
    return 0;
}