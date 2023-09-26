#!/bin/bash
swayidle -w \
	timeout 120 ' swaylock -f' \
	before-sleep 'swaylock -f'

