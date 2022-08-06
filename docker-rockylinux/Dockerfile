FROM rockylinux:9
RUN yum install -y iproute git sudo tmux zsh vim
RUN rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime && \
    adduser --shell /bini/zsh kiran && \
    echo "kiran ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
USER kiran
WORKDIR /home/kiran
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    python3 -m venv .venv && \
    echo "export PATH=\$HOME/.venv/bin:\$PATH" >> .zshrc && \
    echo "export LC_ALL=en_US.UTF-8" >> .zshrc && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="kiran"/' .zshrc
COPY kiran.zsh-theme .oh-my-zsh/themes
CMD /bin/zsh -l
