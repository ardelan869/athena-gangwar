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

shared_script 'config/sh_config.lua'

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'config/sv_config.lua',
    'server/main.lua',
    'server/functions/utils.lua',
    'server/functions/players.lua',
    'server/functions/logs.lua',
}

client_scripts{
    'config/cl_config.lua',
    'client/*.*',
    'client/**/*.*'
}