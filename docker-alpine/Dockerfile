FROM alpine
RUN apk add -U python3 py3-pip curl git zsh sudo && \
    adduser -D -s /bin/zsh kiran && \
    echo "kiran ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
USER kiran
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
WORKDIR /home/kiran
CMD /bin/zsh
