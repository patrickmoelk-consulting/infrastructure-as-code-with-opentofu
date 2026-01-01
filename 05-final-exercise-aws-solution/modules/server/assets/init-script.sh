#!/usr/bin/env bash

function main() {
  apt_update_and_upgrade

  # install_nvm_and_nodejs
  install_pyenv
  install_poetry
  install_reverse_proxy_caddy

  install_backend_dependencies

  setup_backend_service
  setup_frontend_with_caddy
}

function apt_update_and_upgrade() {
  print_banner "running apt update..."
  sudo apt update
  print_banner "DONE running apt update"

  print_banner "running apt upgrade..."
  sudo NEEDRESTART_MODE=a apt upgrade -y
  print_banner "DONE running apt upgrade"
}


function install_nvm_and_nodejs() {
  print_banner "installing nvm..."

  ## from: https://nodejs.org/en/download
  # Download and install nvm:
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

  # in lieu of restarting the shell
  \. "$HOME/.nvm/nvm.sh"

  print_banner "DONE installing nvm"


  print_banner "installing nodejs v24..."

  # Download and install Node.js:
  nvm install 24

  # Verify the Node.js version:
  node -v # Should print "v24.12.0".

  # Verify npm version:
  npm -v # Should print "11.6.2".

  print_banner "DONE installing nodejs v24"
}


function install_pyenv() {
  print_banner "installing pyenv..."

  curl https://pyenv.run | bash

  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc

  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
  echo 'eval "$(pyenv init - bash)"' >> ~/.profile

  print_banner "DONE installing pyenv"
}

function install_poetry() {
  print_banner "installing poetry..."

  curl -sSL https://install.python-poetry.org | python3 -
  echo 'export PATH="/home/ubuntu/.local/bin:$PATH"' >> ~/.bashrc
  echo 'export PATH="/home/ubuntu/.local/bin:$PATH"' >> ~/.profile

  source ~/.bashrc

  print_banner "DONE installing poetry"
}

function install_reverse_proxy_caddy() {
  print_banner "installing caddy..."

  # from https://caddyserver.com/docs/install#debian-ubuntu-raspbian
  sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
  chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  chmod o+r /etc/apt/sources.list.d/caddy-stable.list
  sudo apt update
  sudo apt install caddy

  print_banner "DONE installing caddy"
}

function install_backend_dependencies() {
  print_banner "installing backend deps..."

  cd /home/ubuntu/apps/todos/backend
  /home/ubuntu/.local/bin/poetry install

  print_banner "DONE installing backend deps"
}

function setup_backend_service() {
  print_banner "copying .env file to /etc/"

  sudo cp /home/ubuntu/apps/todos/backend/.env.prod /etc/todo-list-app-backend.env
  sudo chmod 600 /etc/todo-list-app-backend.env
  sudo chown ubuntu:ubuntu /etc/todo-list-app-backend.env

  print_banner "DONE copying .env file to /etc/"


  ## systemd
  print_banner "setting up backend service..."

  sudo cp /home/ubuntu/apps/todos/todo-list-app-backend.service /etc/systemd/system
  chmod +x /home/ubuntu/apps/todos/backend/start.sh

  sudo systemctl daemon-reload
  sudo systemctl enable todo-list-app-backend.service
  sudo systemctl start todo-list-app-backend.service

  print_banner "DONE setting up backend service"
}


function setup_frontend_with_caddy() {
  print_banner "copying frontend and Caddyfile..."

  sudo cp -r /home/ubuntu/apps/todos/frontend /srv/todo-list-app-frontend
  sudo cp /home/ubuntu/apps/todos/Caddyfile /etc/caddy/Caddyfile

  print_banner "DONE copying frontend and Caddyfile"


  ## restart caddy
  print_banner "restarting caddy..."

  sudo systemctl restart caddy

  print_banner "DONE restarting caddy"
}


function print_banner() {
  text=$1

  echo "================================================"
  echo "${text}"
  echo "================================================"
}


main