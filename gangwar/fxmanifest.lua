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
    'index.js',
    'jsons/cachedidentifier.json',
    'jsons/bans.json',
    'server/webhooks.lua',
    'server/utils/functions.lua',
    'server/utils/player.lua',
    'server/utils/commands.lua',
    'server/main.lua',
}

client_script 'clientcode/load.lua'