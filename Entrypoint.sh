#!/bin/bash

# Terminate the Script on Failure
set -e

# Runs the Container CMD
"$@"

# Restore Default Server Config
if [ "$CFG_RESTORE_DEFAULT" = 1 ]; then
  cat > /L4D2Content/left4dead2/cfg/server.cfg << EOF
// Server Info
sv_region 255
motd_enabled 0

// Game Settings
sv_consistency 0
sv_voiceenable 0
sv_pausable 0
director_no_human_zombies 1
sv_versus_swapteams 1
mp_disable_autokick 1

// Logging
sv_logecho 0
sv_logfile 0

// Network Performance
rate 20000
sv_minrate 4000
sv_maxrate 16000
sv_mincmdrate 15
sv_maxcmdrate 20
sv_minupdaterate 15
sv_maxupdaterate 20

// Security
sv_cheats 0
sv_lan 0
sv_allow_lobby_connect_only 0
sv_allow_wait_command 0

// Stability and Performance
sv_timeout 60
sv_maxplayers 4
sv_forcepreload 0
fps_max 30
EOF
fi

# Start Game Server
if [ "$SRV_LAUNCH_SERVER" = 1 ]; then
  export LD_LIBRARY_PATH=/L4D2Content/bin:/L4D2Content/left4dead2/bin:$LD_LIBRARY_PATH:/SteamCMD/linux32:/SteamCMD/linux64
  cd /L4D2Content
  exec ./srcds_linux \
    -console \
    -game left4dead2 \
    -port $SRV_PORT \
    -tickrate 30 \
    -noipx \
    $( [ "$SRV_SECURE_SERVER" = 1 ] && echo "-secure" || echo "-insecure" ) \
    +map "c14m1_junkyard" \
    +hostname "$CFG_INFORMATION_HOSTNAME" \
    +sv_steamgroup "$CFG_INFORMATION_STEAM_GROUP" \
    +sv_gametypes "$CFG_SETTINGS_GAME_TYPE" \
    +z_difficulty expert \
    </dev/null
fi
