mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.buffer_editor = "hx"

$env.config.show_banner = false

## ${UserConfigDir}/nushell/env.nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# ${UserConfigDir}/nushell/config.nu


alias nvim = nix run github:vnikjr/nvf -- 
alias f = hyfetch 

#~/.config/nushell/config.nu
source $"($nu.cache-dir)/carapace.nu"
