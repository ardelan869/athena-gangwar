fx_version 'cerulean'
game 'gta5'

author 'Indian Tech Supporter'
description 'minecraft texture pack'

ui_page 'html/index.html'
files {
    'html/index.html',
    'html/**/**/*.*',
    'html/**/**/**/*.*',
}

shared_script 'shared/*.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'jsons/cachedidentifier.json',
    'jsons/bans.json',
    'server/utils/functions.lua',
    'server/utils/player.lua',
    'server/utils/commands.lua',
    'server/main.lua',
}

client_scripts {
    'client/config.lua',
    'client/utils/ipl.lua',
    'client/utils/functions.lua',
    'client/utils/death.lua',
    'client/utils/events.lua',
    'client/utils/nuicb.lua',
    'client/utils/commands.lua',
    'client/utils/xmenu.lua',
    'client/main.lua',
}
