#! /usr/bin/env nix-shell
#! nix-shell -i nu -p nushell git

def "check_folder_in_git" [folder: string] {
  echo $"checking ($folder)"
  let length = git status ./$folder --porcelain | length
  return ($length > 0)
}

def "main" [
  --force (-f)
  --home_manager
  --nixos
] {
  git add * | save /dev/null -f
  mut rebuild_nix = false
  mut rebuild_home_manager = false
  if $home_manager {
    $rebuild_home_manager = true
  }
  if $nixos {
    $rebuild_nix = true
  }
  if $force {
    $rebuild_nix = true
    $rebuild_home_manager = true
  }

  if (check_folder_in_git "home-manager") {
    echo "change to home-manager"
    $rebuild_home_manager = true
  }
  if (check_folder_in_git "nixos") {
    echo "change to nixos"
    $rebuild_nix = true
  }
  if (check_folder_in_git "device_specific") {
    $rebuild_nix = true
    $rebuild_home_manager = true
  }

  if $rebuild_nix {
    echo "rebuild_home_managering nix"
    echo "$(git status ./nixos --porcelain)"
    sudo nixos-rebuild switch --flake .
  }
  if $rebuild_home_manager {
    echo "rebuilding home manager"
    echo "$(git status ./home-manager --porcelain)"
    home-manager switch --flake .
  }

  mut commit_message = ""
  if $rebuild_nix {
    let nixgen = nixos-rebuild list-generations --json | from json | where current == true
    $commit_message = $"Nix generation: ($nixgen.generation | first) ($nixgen.date | first) kernel ($nixgen.kernelVersion | first)"
  }
  if $rebuild_home_manager {
    let homegen = home-manager generations | grep current
    $commit_message = $commit_message ++ $homegen
  }
  if (($commit_message | str length) > 0) {
    git commit -am $commit_message 
  }
}
