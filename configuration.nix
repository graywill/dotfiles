{ user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;          # fast key repeat
      InitialKeyRepeat = 15;  # short delay before repeat
      _HIHideMenuBar = true;  # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";  # list view by default
    finder.CreateDesktop = false;          # clean desktop
    trackpad.Clicking = true;              # tap to click
  };
  nix-homebrew = {
    enable = true;
    inherit user;
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";  # remove anything not listed here
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];

    # Snapshot from this machine (2026-07-18):
    # - brews = `brew leaves` + tap-sourced top-level tools
    # - casks = disk-verified present installs only
    # Orphaned (app gone, intentionally omitted): phpstorm, android-studio, skype
    # Alias dups collapsed to canonical names:
    #   gitup → gitup-app, tailscale → tailscale-app,
    #   temurin8 → temurin@8, wireshark → wireshark-app
    taps = [
      "nicoverbruggen/cask" # phpmon
      "openclaw/tap" # gogcli
      "stripe/stripe-cli"
      "stripe/stripe-mock"
      "xdevplatform/tap" # xurl
    ];

    brews = [
      # previously declared
      "herdr"

      # brew leaves (top-level)
      "awscli"
      "bash"
      "bat"
      "bundletool"
      "composer"
      "coreutils"
      "docutils"
      "ffmpeg"
      "geckodriver"
      "gh"
      "gifsicle"
      "git"
      "gobject-introspection"
      "graphicsmagick"
      "grep"
      "htop"
      "httpie"
      "imagemagick"
      "jpegoptim"
      "jq"
      "libfido2"
      "mackup"
      "mas"
      "meilisearch"
      "mysql"
      "neovim"
      "nginx"
      "nmap"
      "openjdk@11"
      "openjdk@17"
      "optipng"
      "php@7.4"
      "picocom"
      "pngquant"
      "poppler"
      "putty"
      "python@3.10"
      "python@3.11"
      "python@3.9"
      "redis"
      "ripgrep"
      "subversion"
      "supabase"
      "svgo"
      "tmux"
      "yarn"

      # tap-sourced top-level (not always shown by `brew leaves` when tap is untrusted)
      "openclaw/tap/gogcli"
      "stripe/stripe-cli/stripe"
      "stripe/stripe-mock/stripe-mock"
    ];

    casks = [
      # previously declared (not in prior brew list; kept as desired state)
      "claude-code"
      "wezterm"

      # disk-verified present casks
      "adobe-acrobat-reader"
      "adobe-creative-cloud"
      "alfred"
      "android-platform-tools"
      "arduino-ide"
      "audacity"
      "azure-data-studio"
      "dbeaver-community"
      "dbngin"
      "docker-desktop"
      "dropbox"
      "evernote"
      "figma"
      "firefox"
      "font-lato"
      "font-open-sans"
      "font-roboto"
      "font-source-code-pro"
      "font-source-code-pro-for-powerline"
      "font-source-sans-3"
      "font-source-serif-4"
      "fork"
      "github"
      "gitup-app"
      "google-chrome"
      "imageoptim"
      "iterm2"
      "keepassxc"
      "logseq"
      "marta"
      "obsidian"
      "pastebot"
      "nicoverbruggen/cask/phpmon"
      "postman"
      "qlmarkdown"
      "quicklook-json"
      "screenflow"
      "slack"
      "tableplus"
      "tailscale-app"
      "temurin@8"
      "the-unarchiver"
      "thonny"
      "transmit"
      "visual-studio-code"
      "vlc"
      "vnc-viewer"
      "wireshark-app"
      "xurl"
      "zoom"
    ];
  };
}
