#include <riscv_vector.h>
#include <stdio.h>

int main() {
    float a[] = {1.0, 2.0, 3.0, 4.0};
    float b[] = {10.0, 20.0, 30.0, 40.0};
    float c[4];

    size_t vl = __riscv_vsetvl_e32m1(4); // Configura el ancho del vector
    vfloat32m1_t va = __riscv_vle32_v_f32m1(a, vl);
    vfloat32m1_t vb = __riscv_vle32_v_f32m1(b, vl);
    vfloat32m1_t vc = __riscv_vfadd_vv_f32m1(va, vb, vl);
    
    __riscv_vse32_v_f32m1(c, vc, vl);

    printf("Resultado: %.1f, %.1f, %.1f, %.1f\n", c[0], c[1], c[2], c[3]);
    return 0;
}
