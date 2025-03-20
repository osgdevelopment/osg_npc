fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."
lua54 "yes"
name "osg_npc"
description "A script to spawn custom peds with animations and time-based spawning."
author 'OSG Development <Discord: OSG Development https://discord.gg/zgu3DJvxPc>'
version "1.0.0"

dependencies {
    "vorp_core",
}

files {
    "config.lua"
}

server_scripts {
    "@vorp_core/init.lua", -- Ensure VORP Core loads first if needed
    "server.lua"
}

client_scripts {
    "client.lua"
}