# Info
Rockylinux container image with sudo, curl, zsh
local user kiran added with sudo access
oh-my-zsh for the local user
start the container as local user in the user's home directory
create a python virtualenv in the localuser and set path to that

# Build
```
docker build -t r .
```

# Run
```
docker run -it --rm r
```

