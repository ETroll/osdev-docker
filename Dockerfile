FROM debian:stretch
MAINTAINER Karl Syvert Løland <karl.syvert@myerart.net>

# Set APT_GET_UPDATE to make consistent images
ENV APT_GET_UPDATE 2016-03-01
ENV code /src
ENV toolchain /toolchain

RUN DEBIAN_FRONTEND=noninteractive apt-get --quiet --yes update \
    && DEBIAN_FRONTEND=noninteractive apt-get --quiet --yes install \
        binutils \
        gcc \
        g++ \
        nasm \
        make \
        wget \
        libmpc-dev \
        grub \
        grub-pc-bin \
        xorriso \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

RUN wget http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz \
    && tar xvzf binutils-2.24.tar.gz \
    && cd binutils-2.24 \
    && ./configure --prefix=${toolchain} --target=i686-elf --disable-nls --disable-werror --with-sysroot\
    && make \
    && make install \
    && cd .. \
    && rm -rf binutils-2.24 \
    && rm binutils-2.24.tar.gz

RUN wget http://ftp.gnu.org/gnu/gcc/gcc-4.9.4/gcc-4.9.4.tar.gz \
    && tar xvzf gcc-4.9.4.tar.gz \
    && mkdir build-gcc \
    && cd build-gcc \
    && ../gcc-4.9.4/configure --prefix=${toolchain} --target=i686-elf --disable-nls --enable-languages=c,c++ --without-headers --disable-werror\
    && make all-gcc\
    && make all-target-libgcc\
    && make install-gcc\
    && make install-target-libgcc \
    && cd .. \
    && rm -rf build-gcc \
    && rm -rf gcc-4.9.4 \
    && rm gcc-4.9.4.tar.gz

RUN DEBIAN_FRONTEND=noninteractive apt-get --quiet --yes remove \
    g++ \
    wget \
    libmpc-dev

# COPY . ${code}
ENV PATH="${toolchain}/bin:${PATH}"
WORKDIR ${code}
ENTRYPOINT ["/bin/bash"]
