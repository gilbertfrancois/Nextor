#!/usr/bin/env bash
#
# Installs the N80, LK80 and LB80 tools from the Nestor80 project. The script
# is intended to be run in a Docker container.

set -e

if [ $(uname -m) == 'x86_64' ]; then
	wget -O /downloads/n80.zip https://github.com/Konamiman/Nestor80/releases/download/n80-v1.2/N80_${N80_VERSION}_SelfContained_linux-x64.zip
	wget -O /downloads/lk80.zip https://github.com/Konamiman/Nestor80/releases/download/lk80-v1.0/LK80_1.0_SelfContained_linux-x64.zip
	wget -O /downloads/lb80.zip https://github.com/Konamiman/Nestor80/releases/download/lb80-v1.0/LB80_1.0_SelfContained_linux-x64.zip
elif [ $(uname -m) == 'aarch64' ]; then
	wget -O /downloads/n80.zip https://github.com/Konamiman/Nestor80/releases/download/n80-v1.2/N80_${N80_VERSION}_SelfContained_linux-arm64.zip
	wget -O /downloads/lk80.zip https://github.com/Konamiman/Nestor80/releases/download/lk80-v1.0/LK80_1.0_SelfContained_linux-arm64.zip
	wget -O /downloads/lb80.zip https://github.com/Konamiman/Nestor80/releases/download/lb80-v1.0/LB80_1.0_SelfContained_linux-arm64.zip
fi

unzip /downloads/n80.zip
unzip /downloads/lk80.zip
unzip /downloads/lb80.zip
chmod +x N80
chmod +x LK80
chmod +x LB80
mv N80 /usr/bin
mv LK80 /usr/bin
mv LB80 /usr/bin
