#!/bin/bash
ORANGE='\e[38;5;214m'
NC='\033[0m' # No Color
BLUE='\e[38;5;75m' #Yellow
# Comprobar si se ha pasado un archivo
if [ -z "$1" ]; then
    echo "Uso: ./run_rvv.sh nombre_archivo.cpp"
    exit 1
fi

# Extraer el nombre sin la extensión (.cpp)
FILENAME=$(basename "$1" .cpp)

echo -e "${ORANGE}--- ${BLUE}Compilando $1 ${ORANGE}---${NC}"
riscv64-linux-gnu-g++ -march=rv64gcv -mabi=lp64d -static -O3 "$1" -o "$FILENAME"

# Si la compilación tuvo éxito, ejecutar con QEMU
if [ $? -eq 0 ]; then
    echo -e "${ORANGE}--- {BLUE}Ejecutando $FILENAME en QEMU ${ORANGE}---${NC}"
    qemu-riscv64 -cpu rv64,v=true,vext_spec=v1.0,vlen=128 "./$FILENAME"
else
    echo "Error en la compilación."
fi
