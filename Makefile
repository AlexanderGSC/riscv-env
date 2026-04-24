# Configuración del Toolchain
CC      = riscv64-unknown-elf-gcc
CXX     = riscv64-unknown-elf-g++
QEMU    = qemu-riscv64

# Flags de Arquitectura para Vectores (RVV 1.0)
# vlen=128 es el estándar común, pero puedes subirlo a 256 o 512
ARCH_FLAGS = -march=rv64gcv -mabi=lp64d
CFLAGS     = $(ARCH_FLAGS) -O3 -Wall
QEMU_FLAGS = -cpu rv64,v=true,vlen=128

# Archivos
TARGET = main
SRCS   = main.cpp

all: $(TARGET) run

$(TARGET): $(SRCS)
	@echo "Compilando para RISC-V con extensiones vectoriales..."
	$(CXX) $(CFLAGS) $(SRCS) -o $(TARGET)

run:
	@echo "Ejecutando en QEMU (VLEN=128)..."
	$(QEMU) $(QEMU_FLAGS) ./$(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all run clean
