fx_version "cerulean"
game "gta5"

name "TLB API"
description "Standalone API for The Lab"
author "The Lab"
version "1.0.0"

server_scripts {
    'server/config.lua',
    'server/router.lua',
    'server/middleware.lua',
    'server/handler/*.lua',
    'server/routes/*.lua',
    'server/main.lua',
}
