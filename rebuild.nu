#! /usr/bin/env nix-shell
#! nix-shell -i nu -p nushell git

def "check_folder_in_git" [folder: string] {
  echo $"checking ($folder)"
  let length = git status ./$folder --porcelain | str length
  return ($length > 0)
}

def "main" [
  --force (-f)
] {
  git add * | save /dev/null -f
  mut rebuild_nix = false
  if $force {
    $rebuild_nix = true
  }

  if (git status ./modules --porcelain | str length) > 0 {
    echo "change to a module"
    $rebuild_nix = true
  }
  if (git status ./device_specific --porcelain | str length) > 0 {
    $rebuild_nix = true
  }
  if (git status ./flake.nix --porcelain | str length) > 0 {
      $rebuild_nix = true
  }

  if $rebuild_nix {
    if ((sys host | get name) == "Darwin") {
      sudo darwin-rebuild switch --flake .      
    } else {
      sudo nixos-rebuild switch --flake .
    }
  }
  mut commit_message = ""
  if $rebuild_nix {
    let nixgen = if ((sys host | get name) == "Darwin") {darwin-rebuild --list-generations | grep current} else {nixos-rebuild list-generations --json | from json | where current == true}
    $commit_message = $"Nix generation: ($nixgen.generation | first) ($nixgen.date | first) kernel ($nixgen.kernelVersion | first)"
  }
  if (($commit_message | str length) > 0) {
    git commit -am $commit_message
  }
}
