#!/bin/bash

show_help=false
xdg_config="$HOME/.config"
dryrun=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
      -h|-\?|--help) show_help=true ;;
      -c|--config) xdg_config="$2"; shift ;;
      -d|--dry-run) dryrun=true ;;
      *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if $show_help; then
  prog_name="$1"
  echo "Usage: ${prog_name} [options]"
  echo ""
  echo "Available options:"
  echo "  -h, -?, --help: Show this help menu"
  echo "  -c, --config CONFIG_DIR: The XDG_CONFIG_HOME directory to install into (default \"$HOME/.config\")"
  echo "  -d, --dry-run: Don't actually install anything, just print what would have happened"
  exit
fi

should_install() {
  test $dryrun != true
}

check_exists() {
  if test -e "$1"; then
    echo "Uh oh, $1 already exists..."
    # TODO cli option to automate
    read -pr "What to do??" action
    echo "Action $action"
    exit # TODO implement action
  fi
}

push() {
 pushd "$@" >/dev/null || exit 1
}

pop() {
 popd >/dev/null || exit 1
}

# Get absolute filename without relying on `realpath`
# https://stackoverflow.com/a/21188136
get_abs_filename() {
  # $1 : relative filename
  filename=$1
  parentdir=$(dirname "${filename}")

  if [ -d "${filename}" ]; then
      echo "$(cd "${filename}" && pwd)"
  elif [ -d "${parentdir}" ]; then
    echo "$(cd "${parentdir}" && pwd)/$(basename "${filename}")"
  fi
}

## Main

push "config"
for file in * ; do
  if test -d "$file"; then
    target="$(get_abs_filename "$file")"
    dest="${xdg_config}/${file}"
    echo "Installing directory $target at $dest"
    if should_install; then
      ln -s "$target" "$dest"
    fi
  fi
done
pop
