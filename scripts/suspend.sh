#!/bin/bash

swayidle -w \
	timeout 160 ' swaylock -f' \
	before-sleep 'swaylock -f'
