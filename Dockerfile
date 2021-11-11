FROM phusion/baseimage:master

LABEL maintainer="ssrtw <pixar9899@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Taipei

COPY sources.list /etc/apt
RUN apt -y update && apt install -y git gcc g++ gdb python3-dev python3-pip ruby-dev \
    vim zsh tmux tzdata file net-tools \
    build-essential cmake vim-nox netcat \
    tty-clock ntpdate \
    wget nmap sqlmap zstd --fix-missing && \
    rm -rf /var/lib/apt/list/*
# ctf tools
RUN python3 -m pip install --no-cache-dir \
    zdict \
    ropper \
    pwntools \
    ropgadget \
    pycryptodome \
    keystone-engine
RUN gem install one_gadget seccomp-tools && rm -rf /var/lib/gems/2.*/cache/*
RUN wget -O ~/.gdbinit-gef.py -q http://gef.blah.cat/py && \
    echo source ~/.gdbinit-gef.py >> ~/.gdbinit && \
    git clone --depth=1 https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb


COPY --from=skysider/glibc_builder64:2.23 /glibc/2.23/64 /glibc/2.23/64
COPY --from=skysider/glibc_builder32:2.23 /glibc/2.23/32 /glibc/2.23/32

COPY --from=skysider/glibc_builder64:2.24 /glibc/2.24/64 /glibc/2.24/64
COPY --from=skysider/glibc_builder32:2.24 /glibc/2.24/32 /glibc/2.24/32

COPY --from=skysider/glibc_builder64:2.28 /glibc/2.28/64 /glibc/2.28/64
COPY --from=skysider/glibc_builder32:2.28 /glibc/2.28/32 /glibc/2.28/32

COPY --from=skysider/glibc_builder64:2.29 /glibc/2.29/64 /glibc/2.29/64
COPY --from=skysider/glibc_builder32:2.29 /glibc/2.29/32 /glibc/2.29/32

COPY --from=skysider/glibc_builder64:2.30 /glibc/2.30/64 /glibc/2.30/64
COPY --from=skysider/glibc_builder32:2.30 /glibc/2.30/32 /glibc/2.30/32

COPY --from=skysider/glibc_builder64:2.27 /glibc/2.27/64 /glibc/2.27/64
COPY --from=skysider/glibc_builder32:2.27 /glibc/2.27/32 /glibc/2.27/32

COPY linux_server linux_server64 /ctf/
RUN chmod a+x /ctf/linux_server /ctf/linux_server64

ADD oh_my_zsh.sh /tmp
# setting shell
RUN /tmp/oh_my_zsh.sh && \
    rm /tmp/oh_my_zsh.sh && \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    sed -i "s|fg='8'|fg='yellow'|g" ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh && \
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_THEME:-$HOME/.oh-my-zsh}/themes/powerlevel10k && \
    chsh -s /usr/bin/zsh

COPY .p10k.zsh .zshrc .vimrc .tmux.conf .ycm_extra_conf.py .gdbinit /root
COPY crontab /etc

RUN git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    vim +PluginInstall +qall
RUN python3 ~/.vim/bundle/YouCompleteMe/install.py && \
    python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

WORKDIR /ctf/work/

CMD ["/sbin/my_init", "/usr/sbin/ntpdate time.stdtime.gov.tw"]

ENTRYPOINT zsh