FROM ubuntu:23.10

ENV NVIM_VERSION v0.9.5
ARG PLUGIN_NAME

RUN apt-get update
# wget is required for downloading nvim
# git is required by Lazy
RUN apt-get install -y wget git

WORKDIR /work
RUN wget https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux64.tar.gz
RUN tar xvzf nvim-linux64.tar.gz
ENV PATH="/work/nvim-linux64/bin:${PATH}"

COPY . /work/src/nvim-plugins/animated-resize.nvim
COPY tests/entrypoint.bash /work/entrypoint.bash
COPY tests/init.lua /root/.config/nvim/init.lua

# Run once to install Lazy and the plugin
RUN nvim --headless +'qall'

ENTRYPOINT ["/work/entrypoint.bash"]
