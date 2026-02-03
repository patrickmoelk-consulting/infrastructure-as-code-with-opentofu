#!/usr/bin/env bash

function main() {
  apt_update_and_upgrade

  install_reverse_proxy_caddy
  start_frontend_with_caddy
}

function apt_update_and_upgrade() {
  print_banner "running apt update..."
  apt update
  print_banner "DONE running apt update"

  print_banner "running apt upgrade..."
  NEEDRESTART_MODE=a apt upgrade -y
  print_banner "DONE running apt upgrade"
}

function install_reverse_proxy_caddy() {
  print_banner "installing caddy..."

  # from https://caddyserver.com/docs/install#debian-ubuntu-raspbian
  apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
  chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  chmod o+r /etc/apt/sources.list.d/caddy-stable.list
  apt update
  apt install caddy

  print_banner "DONE installing caddy"
}

function start_frontend_with_caddy() {
  cd /home/ubuntu/apps/todos
  caddy run
}


function print_banner() {
  text=$1

  echo "================================================"
  echo "${text}"
  echo "================================================"
}


main