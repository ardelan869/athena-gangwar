fx_version 'cerulean'
game 'gta5'

loadscreen 'html/index.html'
loadscreen_cursor 'yes'
-- loadscreen_manual_shutdown 'yes'
files { 'html/index.html', 'html/**/**/*.*' }

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@gangwar/shared/utils.lua',
    'main.lua'
}