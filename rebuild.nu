#! /usr/bin/env nix-shell
#! nix-shell -i nu -p nushell git

def "check_folder_in_git" [folder: string] {
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
    $rebuild_home_manager = true
  }
  if (check_folder_in_git "nixos") {
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

  if $rebuild_home_manager or $rebuild_nix {
    let gen = nixos-rebuild list-generations --json |from json | where current == true 
    git commit -am $"Nix generation: ($gen.generation | first) ($gen.date | first) kernel ($gen.kernelVersion | first)"
  }
}
