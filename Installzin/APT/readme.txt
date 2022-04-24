discord => Site oficial ou Flatpak
Steam => Site oficial ou Flatpak
ttf-fira-code ttf-fira-sans ttf-jetbrains-mono ttf-cascadia-code  => Baixar dos sites oficiais porque não tem no Repo
Lutris => Site oficial baixar .deb

## PipeWire
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream
sudo apt update
sudo apt install pipewire pipewire-audio-client-libraries
sudo apt install gstreamer1.0-pipewire libpipewire-0.3-{0,dev,modules} libspa-0.2-{bluetooth,dev,jack,modules} pipewire{,-{audio-client-libraries,pulse,media-session,bin,locales,tests}}
systemctl --user daemon-reload
systemctl --user --now disable pulseaudio.service pulseaudio.socket
systemctl --user --now enable pipewire pipewire-pulse
