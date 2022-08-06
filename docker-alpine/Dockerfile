FROM alpine
RUN apk add -U python3 py3-virtualenv iproute2 vim curl git zsh sudo tmux tzdata
RUN adduser -D -s /bin/zsh kiran && \
    echo "kiran ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime
USER kiran
WORKDIR /home/kiran
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    python3 -m venv .venv && \
    echo "export PATH=\$HOME/.venv/bin:\$PATH" >> .zshrc && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="kiran"/' .zshrc
COPY kiran.zsh-theme .oh-my-zsh/themes
CMD /bin/zsh -l
