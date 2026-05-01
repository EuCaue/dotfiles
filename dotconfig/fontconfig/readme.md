## Font Configuration Instructions

1. Place the `./fonts.conf` file in `/etc/fonts/`:

   ```bash @p1
   sudo ln -sf ~/dotfiles/fontconfig/fonts.conf /etc/fonts/fonts.conf
   ```

2. Link the font configuration files from your dotfiles to `/etc/fonts/conf.d/`:

   ```bash
   sudo ln -sf ~/dotfiles/fontconfig/conf.d/99-custom-fonts.conf \
     /etc/fonts/conf.d/99-custom-fonts.conf

   sudo ln -sf ~/dotfiles/fontconfig/conf.d/99-mono-override.conf \
     /etc/fonts/conf.d/99-mono-override.conf
   ```

3. Rebuild font cache:

   ```bash
   fc-cache -fv
   ```
