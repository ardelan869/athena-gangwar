const token = LoadResourceFile(GetCurrentResourceName(), 'token');
const { Client, GatewayIntentBits, Partials } = require('discord.js');
const client = new Client({
	intents: [
		GatewayIntentBits.Guilds,
		GatewayIntentBits.GuildMembers,
		GatewayIntentBits.GuildMessages,
		GatewayIntentBits.GuildMessageReactions,
		GatewayIntentBits.GuildBans,
		GatewayIntentBits.MessageContent,
	],
	partials: [Partials.Channel],
});

const ADMINS = [
	'projektleitung',
	'manager',
	'entwickler',
	'superadministrator',
	'administrator',
	'moderator',
	'supporter',
	'user',
];

const BOOSTER = 'ROLE_ID';

const GetUserFromDiscord = (dId) => {
	for (let index = 0; index < GetNumPlayerIndices(); index++) {
		const player = GetPlayerFromIndex(index);
		if (GetPlayerIdentifierByType(player, 'discord').slice(8) == dId)
			return player;
	}
};

client.once('ready', (c) => {
	console.log('^6Bot ^4' + c.user.tag + '^6 wurde gestartet!^0');
});

client.on('guildMemberUpdate', (__, member) => {
	const player = GetUserFromDiscord(member.id);
	if (player)
		emitNet('ath:SetBoosted', player, member.roles.cache.has(BOOSTER));

	for (const [key, role] of member.roles.cache) {
		if (ADMINS.includes(role.name.toLowerCase())) {
			const player = GetUserFromDiscord(member.id);
			exports.gangwar.SetRank(player, role.name.toLowerCase());
			break;
		}
	}
});

client.login(token);
