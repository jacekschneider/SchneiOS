FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    chrpath \
    cpio \
    debianutils \
    diffstat \
    file \
    gawk \
    gcc \
    git \
    iputils-ping \
    libacl1 \
    liblz4-tool \
    locales \
    python3 \
    python3-git \
    python3-jinja2 \
    python3-pexpect \
    python3-pip \
    python3-subunit \
    socat \
    texinfo \
    unzip \
    wget \
    xz-utils \
    zstd \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN groupmod -n schneios-creator ubuntu && \
    usermod -l schneios-creator \
            -d /home/schneios-creator \
            -m ubuntu

# Mount points
RUN mkdir -p \
    /project \
    /work \
    /downloads \
    /sstate && \
    chown -R schneios-creator:schneios-creator \
    /project \
    /work \
    /downloads \
    /sstate

RUN usermod -aG sudo schneios-creator && \
    echo "schneios-creator ALL=(ALL) NOPASSWD:ALL" \
    > /etc/sudoers.d/schneios-creator && \
    chmod 0440 /etc/sudoers.d/schneios-creator

USER schneios-creator

ENV OE_CORE=/project/layers/openembedded-core
ENV BUILD_DIR=/project/build
ENV TEMPLATECONF=$OE_CORE/meta/conf/templates/default

RUN echo 'source "$OE_CORE/oe-init-build-env"' >> /home/schneios-creator/.bashrc

ENTRYPOINT ["bash", "-lc", "mkdir -p /work/build && cp -a /project/build/. /work/build/ && exec bash"]