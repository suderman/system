#!/usr/bin/env bash
local dir="/etc/nixos/secrets" secret 

{ RULES="/etc/nixos/secrets/secrets.nix" agenix --edit "files/foo.age" }

function main {

  # Get secret arg and ensure agenix
  secret="${args[secret]}"
  has agenix || error "agenix missing"

  # Choose secret with menu
  if [[ -z "$secret" ]]; then
    info "Select a secret:"
    secret="$(ask "$(list_secrets) [new]")"
  fi

  # If [new], ask for name of new secret
  if [[ "$secret" == "[new]" ]]; then
    secret="$(ask)"
  fi

  # Add (or use existing) secret by argument name
  # git_stash
  has_secret "$secret" || add_secret "$secret"

  # Edit secret with agenix
  cd $dir && agenix --edit "files/$secret.age" > /dev/null 2>&1

  # show $?

  # Update age/default.nix
  write_nix 

  # Commit on git
  git_commit
  # git_stash_pop

}

# Write the default.nix file compiling all age files
function write_nix {

  # Ouput file path 
  local nix="$dir/files/default.nix"

  info "Writing $nix"

  # Build recursive attribute set
  echo "# Do not modify this file!  It was generated by ‘secrets’ " > $nix
  echo "# and may be overwritten by future invocations. "          >> $nix
  echo "# Please add age files to $dir/files/*.age "               >> $nix
  echo "{"                                                         >> $nix
  echo ""                                                          >> $nix

  # Read each encrypted age file
  for file in $dir/files/*.age; do

    # Derive the attribute key from the filename
    local name=$(basename "$file" ".age")

    # Write the attribute name and path to default.nix
    echo "  $name = ./${name}.age;" >> $nix

  done

  # Finish 
  echo "" >> $nix
  echo "}" >> $nix

  show "echo \"{ ... }\" > $nix"

}

function list_secrets {
  local nix="$dir/secrets.nix"
  nix-instantiate --eval --expr "(import $nix)" | tr ";" "\n" | awk -F/ '{split($2, arr, "."); printf "%s ", arr[1]} END {print ""}'
}

function has_secret {
  [[ -z "$1" ]] && { return 1; }
  local nix="$dir/secrets.nix"
  local output="$(nix-instantiate --eval --expr "(import $nix).\"files/$1.age\"" 2>/dev/null)"
  [[ -z "$output" ]] && { return 1; }
  return 0
}

function add_secret {
  [[ -z "$1" ]] && { return 1; }
  local nix="$dir/secrets.nix"
  task "sed -i '$ d' ${nix}"
  task "echo '  \"files/$1.age\".publicKeys = all;' >> $nix"
  task "echo '' >> $nix"
  task "echo '}' >> $nix"
}

function git_stash {
  task "cd $dir && git stash"
}

function git_commit {
  task "cd $dir && git add . && git commit -m \"secret: $secret\""
}

function git_stash_pop {
  task "cd $dir && git stash pop"
}

main
