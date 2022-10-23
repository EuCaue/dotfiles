#!/bin/bash
sudo systemctl enable --now preload &&
sudo systemctl enable --now gamemode &&
sudo systemctl enable --now bluetooth &&
sudo systemctl enable --now preload &&
sudo systemctl enable --now fstrim.service &&
sudo systemctl enable --now NetworkManager
