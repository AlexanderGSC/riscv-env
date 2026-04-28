# RISC-V Vector Development Environment

Este entorno proporciona un laboratorio completo para el desarrollo y experimentación con la **Extensión de Vectores de RISC-V (RVV 1.0)**. Está basado en Ubuntu 24.04 y configurado para compilar y ejecutar código C++ y Rust optimizado para SIMD.

## 🚀 Características principales
- **Compilador C/C++:** GCC 13.3 (Cross-compiler para `riscv64-linux-gnu`).
- **Entorno Rust:** Rust 1.94 con target `riscv64gc-unknown-linux-gnu`.
- **Emulación:** QEMU 8.2.2 configurado para soportar vectores de 128-bit (VLEN128).
- **Optimización de espacio:** Imagen Docker multi-capa optimizada (~860MB comprimidos).

## 🛠️ Estructura del Entorno
Al iniciar el contenedor, se ejecuta automáticamente un script de verificación (`check-env.sh`) y se activa un prompt personalizado:
- **Prompt:** `RISC-V-Dev /app$ ` (Amarillo/Verde para fácil identificación).
- **Alias útil:** `qv` (Abreviatura para ejecutar QEMU con soporte vectorial).

## 📂 Uso del Contenedor

Para arrancar el entorno vinculando tu carpeta local:
```bash
docker run -it --rm -v $(pwd):/app riscv-env
```
## 💻 Compilación y Ejecución (C++)
1. Compilación manual
Para compilar código con autovectorización o intrínsecas:

```bash
riscv64-linux-gnu-g++ -march=rv64gcv -mabi=lp64d -static -O3 main.cpp -o main
```

## 💻 Ejecución con QEMU
Usa el alias configurado o el comando completo:

- Usando el alias
```bash 
qv ./main
```
- Comando completo
```bash 
qemu-riscv64 -cpu rv64,v=true,vext_spec=v1.0,vlen=128 ./main
```
## 🔍 Inspección de Código (Ensamblador)
Para verificar si el compilador está generando instrucciones vectoriales (vsetvli, vle32, vfadd, etc.):

```bash
riscv64-linux-gnu-objdump -d ./main | grep -E "vset|vle|vse|vadd|vfadd"
```

## Salida de Docker
```bash
=========================================
   RISC-V DEVELOPMENT ENVIRONMENT
=========================================
# C Compiler (Bare-metal):
riscv64-linux-gnu-gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0

# C++ Compiler (Bare-metal):
riscv64-linux-gnu-g++ (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0

# QEMU User Mode:
qemu-riscv64 version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.16)

# QEMU System Mode:
QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.16)

# Rust Compiler:
rustc 1.94.1 (e408947bf 2026-03-25)

# Rust Targets:
riscv64gc-unknown-linux-gnu

=========================================
```

## 📝 Notas de Configuración
VLEN: Los registros vectoriales están configurados a 128 bits por defecto en la emulación. Puedes probar anchos mayores (256, 512) cambiando el parámetro vlen en QEMU.

Volúmenes: El contenedor está configurado para trabajar en ```/app```. Cualquier archivo creado aquí persistirá en tu máquina host.