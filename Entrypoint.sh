#!/bin/bash

# Runs the Container CMD
"$@"

# Restore Default Server Config
if [ "$CFG_RESTORE_DEFAULT" = 1 ]; then
  cat > /L4D2Content/left4dead2/cfg/server.cfg << EOF
// Server Info
sv_region 255
motd_enabled 0

// Initial Level
map "c14m1_junkyard"
z_difficulty expert

// Game Settings
sv_consistency 0
sv_voiceenable 0
sv_pausable 0
director_no_human_zombies 1
sv_versus_swapteams 1

// Logging
sv_logecho 1
sv_logfile 0

// Network Performance
rate 20000
sv_minrate 5000
sv_maxrate 20000
sv_mincmdrate 20
sv_maxcmdrate 40
sv_minupdaterate 15
sv_maxupdaterate 30

// Security
sv_cheats 0
sv_lan 0
sv_allow_lobby_connect_only 0
sv_allow_wait_command 0

// Stability and Performance
sv_timeout 60
sv_maxplayers 8
sv_forcepreload 1
fps_max 60
EOF
fi

# Start Game Server
if [ "$SRV_LAUNCH_SERVER" = 1 ]; then
  export LD_LIBRARY_PATH=/L4D2Content/bin:/L4D2Content/left4dead2/bin:$LD_LIBRARY_PATH:/SteamCMD/linux32:/SteamCMD/linux64
  cd /L4D2Content
  exec ./srcds_linux \
    -console \
    -game left4dead2 \
    -port "$SRV_PORT" \
    +hostname "$CFG_INFORMATION_HOSTNAME" \
    +sv_steamgroup "$CFG_INFORMATION_STEAM_GROUP" \
    +sv_gametypes "$CFG_SETTINGS_GAME_TYPE" \
    $( [ "$SRV_SECURE_SERVER" = 1 ] && echo "-secure" || echo "-insecure" ) \
    -noipx \
    </dev/null
fi
