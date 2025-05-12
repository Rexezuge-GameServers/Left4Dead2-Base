FROM debian:12-slim AS runtime

# Volume Mounting Directory
RUN mkdir /SteamCMD \
 && mkdir /L4D2Content

# Add Dependency
RUN dpkg --add-architecture i386 \
 && apt update \
 && apt upgrade -y \
 && apt install -y --no-install-recommends lib32gcc-s1 libc6-i386

# Add Files
ADD Entrypoint.sh /.Entrypoint.sh

# Make Entrypoint Executable
RUN chmod +x /.Entrypoint.sh

# Uninstall Package Manager
RUN apt install -y --no-install-recommends ca-certificates \
 && apt clean \
 && apt autoremove --purge -y \
 && apt autoremove --purge apt --allow-remove-essential -y \
 && rm -rf /var/log/apt /etc/apt \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Setup User
RUN useradd --uid 27015 -m steam

# Grant Permission to User
RUN chown -R steam:steam /SteamCMD \
 && chown -R steam:steam /L4D2Content

# Change User
USER steam
WORKDIR /home/steam

# Softlink Steam Library
RUN mkdir ~/.steam \
 && mkdir ~/.steam/sdk32/ \
 && ln -s /SteamCMD/linux32/steamclient.so ~/.steam/sdk32/steamclient.so \
 && mkdir ~/.steam/sdk64/ \
 && ln -s /SteamCMD/linux64/steamclient.so ~/.steam/sdk64/steamclient.so

# Remove Intermediate Layer
FROM scratch

COPY --from=runtime / /

# Change User
USER steam
WORKDIR /home/steam

# Port Forwarding
#   Only Game Server Port is Open by Default
#   Uncomment the Following Line if You Want RCON
# EXPOSE 27015/tcp
EXPOSE 27015/udp

# Environment(s)
ENV SRV_PORT=27015 \
    SRV_SECURE_SERVER=1 \
    SRV_LAUNCH_SERVER=1
ENV CFG_INFORMATION_HOSTNAME="Community-Left4Dead2-World-Server" \
    CFG_INFORMATION_STEAM_GROUP=0 \
    CFG_SETTINGS_GAME_TYPE="coop,realism"

# Set Entrypoint
ENTRYPOINT ["/bin/bash", "/.Entrypoint.sh"]
