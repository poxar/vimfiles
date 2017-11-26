#!/bin/sh
set -eu

GH_URL="https://github.com/"
PARALLEL=5

SED_REPO="s,.*:::,$GH_URL,"
SED_PATH="s,:::.*/,/,"
SED_NAME="s,.*:::,,"

vim_cmd() {
  dir="$1"

  if echo "$dir" | grep 'nvim' >/dev/null 2>&1; then
    echo "nvim"
  elif echo "$dir" | grep '.vim' >/dev/null 2>&1; then
    echo "vim"
  else
    exit 1
  fi
}

help_tags() {
  $(vim_cmd "$PWD") "+helptags ALL" "+quit"
}

pack_conf() {
  grep -v '^#' packages.conf | grep -v '^$' | sed 's,	,:::,'
}

pack_inst() {
  find . -mindepth 3 -maxdepth 3 -type d | sed 's,^\./,,' | grep -v '^local/'
}

install() {
  package=$1
  name=$(echo "$package" | sed "$SED_NAME")
  repo=$(echo "$package" | sed "$SED_REPO")
  path=$(echo "$package" | sed "$SED_PATH")

  if ! test -d "$path"; then
    echo "Installing $name"
    mkdir -p "$(dirname "$path")"
    git clone --quiet --depth=1 "$repo" "$path" >/dev/null 2>&1 || echo "Error in $name"
  fi
}

update() {
  package=$1
  name=$(echo "$package" | sed "$SED_NAME")
  repo=$(echo "$package" | sed "$SED_REPO")
  path=$(echo "$package" | sed "$SED_PATH")

  if test -d "$path"; then
    echo "Updating $name"
    (cd "$path" && git pull >/dev/null 2>&1 || echo "Error in $name")
  fi
}

not_configured() {
  configured=$(mktemp)
  installed=$(mktemp)

  pack_inst | sort >> "$installed"
  pack_conf | sed "$SED_PATH" | sort >> "$configured"

  comm -23 "$installed" "$configured"

  rm -f "$installed" "$configured"
}

clean() {
  for package in $(not_configured); do
    rm -rf "$package"
  done
}

par() {
  for package in $(pack_conf); do
    while test "$(jobs | wc -l)" -ge $PARALLEL; do
      sleep 0.1
    done

    "$1" "$package" &
  done

  wait
}

usage() {
  echo "Usage: $0 ACTION"
  echo 'Manage vim8/neovim packages.'
  echo ''
  echo 'ACTION is one of:'
  echo '  help    - show this message'
  echo '  tags    - regenerate all help tags'
  echo '  clean   - delete installed packages that are not configured'
  echo '  list    - list packages that would be cleaned'
  echo '  update  - update installed packages'
  echo '  install - install missing packages'
  echo ''
  echo 'Packages are configured in pack/packages.conf like this:'
  echo ''
  echo '    default/start:::tpope/vim-commentary'
  echo ''
  echo 'This would clone https://github.com/tpope/vim-commentary'
  echo 'and install it to "pack/default/start/vim-commentary"'
  echo ''
  echo 'You may use a tab character instead of ":::".'
  echo 'Lines starting with # and empty lines are ignored.'
  echo ''
  echo 'Packages installed in "pack/local" will never be cleaned.'
}

main() {
  action=${1:-""}
  cd "$(dirname "$0")" || exit 1

  case "$action" in
    help)    usage                    ;;
    tags)    help_tags                ;;
    list)    not_configured           ;;
    clean)   clean && help_tags       ;;
    update)  par update && help_tags  ;;
    install) par install && help_tags ;;
    *)       usage && exit 1          ;;
  esac

  exit 0
}

main "$@"
