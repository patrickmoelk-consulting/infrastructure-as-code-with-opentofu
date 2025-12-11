#!/usr/bin/env bash

echo "================================================"
echo "running apt update"
echo "================================================"

sudo apt update

echo "================================================"
echo "DONE running apt update"
echo "================================================"



echo "================================================"
echo "running apt upgrade"
echo "================================================"

sudo NEEDRESTART_MODE=a apt upgrade -y

echo "================================================"
echo "DONE running apt upgrade"
echo "================================================"



## installing nvm and nodejs
# echo "================================================"
# echo "installing nvm"
# echo "================================================"
# ## from: https://nodejs.org/en/download
# # Download and install nvm:
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# # in lieu of restarting the shell
# \. "$HOME/.nvm/nvm.sh"

# echo "================================================"
# echo "DONE installing nvm"
# echo "================================================"

# echo "================================================"
# echo "installing nodejs v24"
# echo "================================================"
# # Download and install Node.js:
# nvm install 24

# # Verify the Node.js version:
# node -v # Should print "v24.12.0".

# # Verify npm version:
# npm -v # Should print "11.6.2".

# echo "================================================"
# echo "DONE installing nodejs v24"
# echo "================================================"



## install pyenv
echo "================================================"
echo "installing pyenv"
echo "================================================"

curl https://pyenv.run | bash

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init - bash)"' >> ~/.profile

echo "================================================"
echo "DONE installing pyenv"
echo "================================================"

## install poetry
echo "================================================"
echo "installing poetry"
echo "================================================"

curl -sSL https://install.python-poetry.org | python3 -
echo 'export PATH="/home/ubuntu/.local/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="/home/ubuntu/.local/bin:$PATH"' >> ~/.profile

source ~/.bashrc

echo "================================================"
echo "DONE installing poetry"
echo "================================================"


## install reverse proxy: caddy
echo "================================================"
echo "installing caddy"
echo "================================================"

# from https://caddyserver.com/docs/install#debian-ubuntu-raspbian
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
chmod o+r /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

echo "================================================"
echo "DONE installing caddy"
echo "================================================"


## installing backend deps
echo "================================================"
echo "installing backend deps"
echo "================================================"

cd /home/ubuntu/apps/todos/backend
/home/ubuntu/.local/bin/poetry install
# poetry run fastapi dev src/todos/main.py

echo "================================================"
echo "DONE installing backend deps"
echo "================================================"

## create environment variable file at /etc/todo-list-app-backend.env
## specify variables: VARIABLE=value
# sudo chmod 600 /etc/todo-list-app-backend.env
# sudo chown ubuntu:ubuntu /etc/todo-list-app-backend.env


## systemd
echo "================================================"
echo "setting up backend service"
echo "================================================"

sudo cp /home/ubuntu/apps/todos/todo-list-app-backend.service /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable todo-list-app-backend.service
sudo systemctl start todo-list-app-backend.service

echo "================================================"
echo "DONE setting up backend service"
echo "================================================"


## setting up frontend with caddy
echo "================================================"
echo "copying frontend and Caddyfile"
echo "================================================"

sudo cp -r /home/ubuntu/apps/todos/frontend /srv/todo-list-app-frontend
sudo cp /home/ubuntu/apps/todos/Caddyfile /etc/caddy/Caddyfile

echo "================================================"
echo "DONE copying frontend and Caddyfile"
echo "================================================"


## restart caddy
echo "================================================"
echo "restarting caddy"
echo "================================================"

sudo systemctl restart caddy

echo "================================================"
echo "DONE restarting caddy"
echo "================================================"
