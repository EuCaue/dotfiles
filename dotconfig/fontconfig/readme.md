# Font Configuration Instructions

1. Place the `./fonts.conf` file in `/etc/fonts/`.
2. Place the `./56-mono.conf` file in `/usr/share/fontconfig/conf.avail/`.
3. Navigate to `/etc/fonts/conf.d/` and run:
   ```bash
   sudo ln -s /usr/share/fontconfig/conf.avail/56-mono.conf 56-mono.conf
   ```
4. Create the symlinks listed in the `./font-options-symlinks` directory.
