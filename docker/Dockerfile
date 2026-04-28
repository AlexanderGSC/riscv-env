FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
# Unificamos el PATH para Rust y herramientas de build
ENV PATH="/root/.cargo/bin:/usr/bin/riscv64-linux-gnu:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ca-certificates \
    curl \
    git \
    nano \
    pkg-config \
    libssl-dev \
    # Compiladores cruzados (Cross-compilers)
    gcc-riscv64-linux-gnu \
    g++-riscv64-linux-gnu \
    # Emulación
    qemu-user \
    qemu-system-misc \
    # Depuración
    gdb-multiarch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # Rust para RISC-V
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal \
    && /root/.cargo/bin/rustup target add riscv64gc-unknown-linux-gnu

WORKDIR /app

# Alias útiles para no escribir "riscv64-linux-gnu-g++" cada vez
RUN echo 'alias rv-g++="riscv64-linux-gnu-g++ -march=rv64gcv -mabi=lp64d"' >> /root/.bashrc \
    && echo 'alias rv-qemu="qemu-riscv64 -cpu rv64,v=true,vlen=256,vext_spec=v1.0"' >> /root/.bashrc \
    && echo 'export PS1="\[\e[38;5;214m\]RISC-V-Dev\[\e[0m\]:\[\e[38;5;75m\]\w\[\e[0m\]\$ "' >> /root/.bashrc    

#COPY check-env.sh check-env.sh
#RUN chmod +x /app/check-env.sh

CMD ["/bin/bash", "-c", "bash"]
