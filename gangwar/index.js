const token = 'MTA4ODc4OTcxNTI5NTE1ODM1NA.GBp4ex.TDBkqLQxG4uvFe-GC5pvusZv8azJgNn14mjCpI'
const {
    Client,
    ActivityType,
    Events,
    GatewayIntentBits,
    Collection,
    EmbedBuilder,
    Partials,
    ChannelType,
    ChannelFlags,
    ChannelFlagsBitField,
    ChannelManager,
    PermissionsBitField,
    ActionRowBuilder,
    ButtonBuilder,
    ButtonStyle
} = require('discord.js');
const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMembers,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.GuildMessageReactions,
        GatewayIntentBits.GuildBans,
        GatewayIntentBits.MessageContent
    ],
    partials: [
        Partials.Channel
    ]
})

const ADMINS = [
    'projektleitung',
    'manager',
    'entwickler',
    'superadministrator',
    'administrator',
    'moderator',
    'supporter',
    'user'
]

const GetUserFromDiscord = dId => {
    for (let index = 0; index < GetNumPlayerIndices(); index++) {
        const player = GetPlayerFromIndex(index)
        if (GetPlayerIdentifierByType(player, 'discord').slice(8) == dId) return player;
    }
}

client.once('ready', c => {
    console.log('^6Bot ^4' + c.user.tag + '^6 wurde gestartet!^0')
});

client.on('guildMemberUpdate', (__, member) => {
    for (const [key, role] of member.roles.cache) {
        if (ADMINS.includes(role.name.toLowerCase())) {
            const player = GetUserFromDiscord(member.id)
            exports.gangwar.SetRank(player, role.name.toLowerCase())
            break
        };
    }
});

client.login(token);