FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python2-dev \
    python2 \
    python3-dev \
    python3 \
    wget \
    curl \
    unzip \
    gcc-12 \
    ripgrep \
    fd-find


RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    ln -s /squashfs-root/AppRun /usr/bin/nvim


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    . ~/.bashrc && \
    nvm install 18 && \
    nvm use 18

RUN mkdir -p /root/.config/nvim

COPY . /root/.config/nvim

CMD ["bash"]
