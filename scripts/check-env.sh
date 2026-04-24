#!/bin/bash

# Colores para que se vea mejor
ORANGE='\e[38;5;214m'
NC='\033[0m' # No Color
BLUE='\e[38;5;75m' #Yellow

echo -e "${ORANGE}====================================================${NC}"
echo -e "${BLUE}   RISC-V DEVELOPMENT ENVIRONMENT        ${NC}"
echo -e "${ORANGE}====================================================${NC}"

# Función para imprimir versiones de forma limpia
print_version() {
    echo -e "${BLUE}# $1:${NC}"
    $2 --version | head -n 1
    echo ""
}

# 1. Compiladores
print_version "C Compiler (Linux)" "riscv64-linux-gnu-gcc"
print_version "C++ Compiler (Linux)" "riscv64-linux-gnu-g++"

# 2. Emuladores
print_version "QEMU User Mode" "qemu-riscv64"
print_version "QEMU System Mode" "qemu-system-riscv64"

# 3. Rust (si está instalado)
if command -v rustc &> /dev/null; then
    print_version "Rust Compiler" "rustc"
    echo -e "${BLUE}# Rust Targets:${NC}"
    rustup target list --installed | grep riscv
else
    echo -e "${BLUE}# Rust:${NC} No instalado o no en PATH"
fi

echo ""
echo -e "${ORANGE}=====================================================${NC}"
echo -e "Tip: Para compilar con el soporte vectorial 1.0, usa::"
echo -e "riscv64-linux-gnu-g++ -march=${ORANGE}rv64gcv${NC} -mabi=${ORANGE}lp64d${NC} <origen> -o <destino>"
echo -e "riscv64-linux-gnu-gcc -march=${ORANGE}rv64gcv${NC} -mabi=${ORANGE}lp64d${NC} <origen> -o <destino>"
