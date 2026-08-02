#!/usr/bin/env bash
set -Eeuo pipefail

echo "==> Setting up packages (RPM + Flatpak + Go tools)"

### Helpers #############################################################

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

install_rpm() {
  echo "==> Installing RPM packages"
  sudo dnf install -y "$@"
}

install_flatpak() {
  echo "==> Installing Flatpak packages"
  flatpak install -y flathub "$@"
}

### Extra repositories #################################################

setup_terra() {
  if ! rpm -q terra-release >/dev/null 2>&1; then
    echo "==> Adding Terra repo"
    sudo dnf install -y \
      https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo
  else
    echo "Terra repo already configured"
  fi
}

setup_zen_copr() {
  if ! dnf repolist | grep -q "zen-browser"; then
    echo "==> Enabling Zen Browser COPR"
    sudo dnf copr enable -y sneexy/zen-browser
  else
    echo "Zen Browser COPR already enabled"
  fi
}

setup_morewaita_copr() {
  if ! dnf repolist | grep -q "morewaita-icon-theme"; then
    echo "==> Enabling MoreWaita COPR"
    sudo dnf copr enable -y rivenirvana/morewaita-icon-theme
  else
    echo "MoreWaita COPR already enabled"
  fi
}

setup_rpm_fusion() {
  if rpm -q rpmfusion-free-release rpmfusion-nonfree-release >/dev/null 2>&1; then
    echo "RPM Fusion already configured"
  else
    echo "==> Adding RPM Fusion (free + nonfree)"
    sudo dnf install -y \
      "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
      "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
  fi
}

### RPM #################################################################

RPM_PACKAGES=(
  adw-gtk3-theme
  bat
  boost-devel
  cmake
  curl
  eza
  fd-find
  fzf
  gcc
  gcc-c++
  git
  git-delta
  gnome-tweaks
  golang-bin
  kitty
  libevdev-devel
  libudev-devel
  lsd
  make
  mpv
  neovim
  nextcloud-client
  nodejs
  npm
  pkg-config
  playerctl
  pnpm
  python3-tmuxp
  ripgrep
  tmux
  yaml-cpp-devel
  yazi
  zoxide
  zsh
)

### Flatpak #############################################################

FLATPAK_PACKAGES=(
  org.gtk.Gtk3theme.adw-gtk3
  org.gtk.Gtk3theme.adw-gtk3-dark
  org.gnome.World.PikaBackup
  page.tesk.Refine
  com.discordapp.Discord
  net.nokyan.Resources
  be.alexandervanhee.gradia
  com.mattjakeman.ExtensionManager
  md.obsidian.Obsidian
  com.valvesoftware.Steam
  com.dec05eba.gpu_screen_recorder
)

### Paths ###############################################################

setup_go_path() {
  mkdir -p "$HOME/.local/bin"
  export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
}

setup_cargo_path() {
  if [ -f "$HOME/.cargo/env" ]; then
    # shellcheck disable=SC1090
    source "$HOME/.cargo/env"
  fi
}

### Go tools ############################################################

install_go_tool() {
  local bin_name="$1"
  local package="$2"

  if has_cmd "$bin_name"; then
    echo "$bin_name already installed"
  else
    echo "==> Installing $bin_name via go install"
    go install "$package"
  fi
}

### TMUX ################################################################

setup_tpm() {
  local tmux_dir="$HOME/dotfiles/dotconfig/tmux"
  local tpm_dir="$tmux_dir/plugins/tpm"

  if [ ! -d "$tpm_dir" ]; then
    echo "==> Cloning TPM into $tpm_dir"
    mkdir -p "$tmux_dir/plugins"
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
  else
    echo "TPM already installed"
  fi
}

### ZSH #################################################################

setup_zdotdir() {
  echo "==> Configuring ~/.zshenv for ZDOTDIR"

  cat >"$HOME/.zshenv" <<'EOF'
export ZDOTDIR="$HOME/.config/zsh"
EOF

  read -r -p "Do you want to switch your default shell to zsh? [y/N] " answer
  [[ "$answer" =~ ^[yY]$ ]] && chsh -s "$(command -v zsh)" "$USER"
}

### Interception tools ##################################################

build_and_install_interception_tools() {
  if has_cmd intercept && has_cmd udevmon; then
    echo "interception-tools already installed"
    return
  fi

  echo "==> Building and installing interception-tools"

  local tmp_dir
  tmp_dir="$(mktemp -d)"

  git clone --depth 1 https://gitlab.com/interception/linux/tools.git \
    "$tmp_dir/interception-tools"

  sed -i 's/cmake_minimum_required(VERSION [0-9.]*/cmake_minimum_required(VERSION 3.5/' \
    "$tmp_dir/interception-tools/CMakeLists.txt"
  cmake -S "$tmp_dir/interception-tools" -B "$tmp_dir/interception-tools/build" \
    -DCMAKE_BUILD_TYPE=Release

  cmake --build "$tmp_dir/interception-tools/build"
  sudo cmake --install "$tmp_dir/interception-tools/build"

  rm -rf "$tmp_dir"
}

build_and_install_caps2esc() {
  if has_cmd caps2esc; then
    echo "caps2esc already installed"
    return
  fi

  echo "==> Building and installing caps2esc"

  local tmp_dir
  tmp_dir="$(mktemp -d)"

  git clone --depth 1 https://gitlab.com/interception/linux/plugins/caps2esc.git \
    "$tmp_dir/caps2esc"

  sed -i 's/cmake_minimum_required(VERSION [0-9.]*/cmake_minimum_required(VERSION 3.5/' \
    "$tmp_dir/caps2esc/CMakeLists.txt"
  cmake -S "$tmp_dir/caps2esc" -B "$tmp_dir/caps2esc/build" \
    -DCMAKE_BUILD_TYPE=Release

  cmake --build "$tmp_dir/caps2esc/build"
  sudo cmake --install "$tmp_dir/caps2esc/build"

  rm -rf "$tmp_dir"
}

setup_caps2esc() {
  echo "==> Configuring caps2esc"

  local intercept_bin caps2esc_bin uinput_bin udevmon_bin
  intercept_bin="$(command -v intercept)"
  caps2esc_bin="$(command -v caps2esc)"
  uinput_bin="$(command -v uinput)"
  udevmon_bin="$(command -v udevmon)"

  if [[ -z "$intercept_bin" || -z "$caps2esc_bin" || -z "$uinput_bin" || -z "$udevmon_bin" ]]; then
    echo "interception binaries not found (intercept/caps2esc/uinput/udevmon); skipping caps2esc setup"
    return 1
  fi

  sudo modprobe uinput || true
  if [[ ! -f /etc/modules-load.d/uinput.conf ]]; then
    echo uinput | sudo tee /etc/modules-load.d/uinput.conf >/dev/null
  fi

  sudo mkdir -p /etc/interception

  sudo tee /etc/interception/udevmon.yaml >/dev/null <<EOF
- JOB: "$intercept_bin -g \$DEVNODE | $caps2esc_bin | $uinput_bin -d \$DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK]
EOF

  sudo tee /etc/systemd/system/udevmon.service >/dev/null <<EOF
[Unit]
Description=Monitor input devices for launching tasks
Wants=systemd-udev-settle.service
After=systemd-udev-settle.service
Documentation=man:udev(7)

[Service]
ExecStart=$udevmon_bin -c /etc/interception/udevmon.yaml
Nice=-20
Restart=on-failure
OOMScoreAdjust=-1000

[Install]
WantedBy=multi-user.target
EOF

  sudo systemctl daemon-reload
  sudo systemctl enable --now udevmon.service
}

### Bun / Zed / Rust ####################################################

setup_bun() {
  echo "==> Installing Bun"
  if ! has_cmd bun; then
    curl -fsSL https://bun.sh/install | bash
  else
    echo "Bun already installed"
  fi
}

setup_zed() {
  echo "==> Installing Zed"
  if ! has_cmd zed; then
    curl -fsSL https://zed.dev/install.sh | sh
  else
    echo "Zed already installed"
  fi
}

setup_megasync() {
  local fedora_version arch package_url

  fedora_version="$(rpm -E %fedora)"
  arch="$(uname -m)"

  case "$arch" in
    x86_64|aarch64) ;;
    *)
      echo "Unsupported architecture for MEGA Sync: $arch"
      return 1
      ;;
  esac

  package_url="https://mega.nz/linux/repo/Fedora_${fedora_version}/${arch}/megasync-Fedora_${fedora_version}.${arch}.rpm"

  echo "==> Installing MEGA Sync (official RPM)"
  sudo dnf install -y "$package_url"
}

setup_rustup() {
  echo "==> Rust (rustup)"
  if ! has_cmd rustup; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  else
    echo "rustup already installed"
  fi
}

setup_cargo_packages() {
  setup_cargo_path

  echo "==> Cargo packages"

  if has_cmd cargo; then
    if ! has_cmd trashy; then
      cargo install trashy
    else
      echo "trashy already installed"
    fi
  else
    echo "cargo not found, skipping cargo installs"
  fi
}

### Flatpak #############################################################

setup_flathub() {
  echo "==> Setting up Flatpak + Flathub"
  if ! flatpak remote-list | grep -q flathub; then
    flatpak remote-add --if-not-exists flathub \
      https://flathub.org/repo/flathub.flatpakrepo
  else
    echo "Flathub already configured"
  fi
}

setup_flatpak_theme_access() {
  echo "==> Allowing Flatpak apps to use host icon themes"
  # MoreWaita (COPR) installs into /usr/share/icons; Flatpak needs explicit access.
  sudo flatpak override --filesystem=/usr/share/icons:ro
}

### Execution ###########################################################

echo
echo "==> Updating system"
sudo dnf upgrade -y

setup_rpm_fusion
setup_terra
setup_zen_copr
setup_morewaita_copr

install_rpm "${RPM_PACKAGES[@]}"

echo
echo "==> Installing MoreWaita icons (COPR)"
install_rpm morewaita-icon-theme

echo
setup_megasync

echo
echo "==> Installing Ghostty (Terra)"
install_rpm ghostty-nightly

echo
echo "==> Installing Zen Browser (COPR)"
install_rpm zen-browser

setup_bun
setup_zed
setup_flathub
install_flatpak "${FLATPAK_PACKAGES[@]}"
setup_flatpak_theme_access

setup_rustup
setup_cargo_packages
setup_go_path

echo
echo "==> Go tools"
install_go_tool sesh github.com/joshmedeski/sesh/v2@latest
install_go_tool lazygit github.com/jesseduffield/lazygit@latest
echo
echo "==> Tmux"
setup_tpm

echo
echo "==> Zsh"
setup_zdotdir

echo
echo "==> Interception tools + caps2esc"
build_and_install_interception_tools
build_and_install_caps2esc
setup_caps2esc

echo
echo "==> Package setup complete"
