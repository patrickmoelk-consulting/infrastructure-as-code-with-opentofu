#!/usr/bin/env bash

function main() {
  apt_update_and_upgrade

  install_prerequisites
  install_pyenv
  install_poetry
  install_backend_dependencies

  start_backend
}

function apt_update_and_upgrade() {
  print_banner "running apt update..."
  apt update
  print_banner "DONE running apt update"

  print_banner "running apt upgrade..."
  NEEDRESTART_MODE=a apt upgrade -y
  print_banner "DONE running apt upgrade"
}

function install_prerequisites() {
  print_banner "installing curl python3 git..."

  ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
  DEBIAN_FRONTEND=noninteractive apt install curl python3 git -y

  print_banner "DONE installing curl python3 git"
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
  echo 'export PATH="/root/.local/bin:$PATH"' >> ~/.bashrc
  echo 'export PATH="/root/.local/bin:$PATH"' >> ~/.profile

  source ~/.profile

  print_banner "DONE installing poetry"
}

function install_backend_dependencies() {
  print_banner "installing backend deps..."

  cd /home/ubuntu/apps/todos/backend
  source ~/.profile
  poetry install

  print_banner "DONE installing backend deps"
}

function start_backend() {
  print_banner "starting backend..."

  chmod +x /home/ubuntu/apps/todos/backend/start.sh
  cd /home/ubuntu/apps/todos/backend
  source /root/.profile
  ./start.sh
}


function print_banner() {
  text=$1

  echo "================================================"
  echo "${text}"
  echo "================================================"
}


main