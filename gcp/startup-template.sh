#!/bin/bash
useradd mmetwalli
echo mmetwalli:962024 | chpasswd
usermod -aG google-sudoers mmetwalli