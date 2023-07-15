const SaveSettings = () =>
	$.post(
		`https://${GetParentResourceName()}/SaveSettings`,
		JSON.stringify(SETTINGS),
	);

const ChangeWeather = (weather) => {
	$('.weather .checkbox').removeClass('checked');
	SETTINGS.Weather = weather;
	$(`.checkbox[data-weather="${weather}"]`).addClass('checked');
	SaveSettings();
};

const ChangeForm = (form) => {
	$('#crosshair').remove();
	SETTINGS.Hitmarker.Form = form;
	$('.form-grid .form').removeClass('active');
	if (HITMARKER_FORMS[form]) {
		$(`.form[data-form="${form}"]`).addClass('active');
		$('#hitmarker').prepend(HITMARKER_FORMS[form]);
	} else {
		$('#inputh').val(form);
		$('#hitmarker').prepend(
			`<img id="crosshair" style="display: none;" src="${form}">`,
		);
	}
	HitColor(SETTINGS.Hitmarker.Color);
	SaveSettings();
};

const HitColor = (hex) => {
	SETTINGS.Hitmarker.Color = hex;
	$('.color.item').removeClass('active');
	$(`.color.item[data-color="${hex}"]`).addClass('active');
	$('#crosshair > *').css('fill', hex);
	if (hex != SETTINGS.Hitmarker.Color) SaveSettings();
};

const SetSound = (sound) => {
	SETTINGS.Hitmarker.Sound = sound;
	$('.sound.item').removeClass('active');
	$(`.sound.item[data-sound="${sound}"]`).addClass('active');
	SaveSettings();
};

const SelectPauseFrame = (cat) => {
	if (OldCat == cat) return;

	if (OldCat) {
		$(`.${OldCat}`).hide();
		$('.option').removeClass('active');
	}
	OldCat = cat;
	$(`.${cat}`).fadeIn();
	$(`.option[cat="${cat}"]`).addClass('active');
};

const playSound = (sound) => {
	const audio = new Audio();
	audio.src = `./assets/audio/${sound}.ogg`;
	audio.play();
};

const _U = (s) => s.charAt(0).toUpperCase() + s.slice(1);

const addZero = (int) => {
	if (int < 10) return '0' + int;
	else return int;
};

const addSpeed = (speed) => {
	if (speed === 0) return (speed = '000');
	else if (speed.toString().length <= 1) return '00' + speed;
	else if (speed.toString().length <= 2) return '0' + speed;
	return speed;
};

const SelectPiece = (cat, texture, drawable) =>
	$.post(
		`https://${GetParentResourceName()}/SelectPiece`,
		JSON.stringify({
			drawable: drawable,
			texture: texture,
			cat: cat,
		}),
	);

const SelectClothCat = () =>
	$.post(`https://${GetParentResourceName()}/FetchCategories`);

const SpawnCar = (name) => {
	$('.garage_container').fadeOut(300);
	$.post(
		`https://${GetParentResourceName()}/SpawnCar`,
		JSON.stringify({
			name: name,
		}),
	);
};

const SelectFaction = (name) => {
	team = name;
	$('.factions').hide();
	$('.faction_clothing').show();
	$.post(
		`https://${GetParentResourceName()}/FetchClothing`,
		JSON.stringify({
			team: name,
		}),
	).then((cb) => {
		$(':root').css(
			'--faction-bg',
			`linear-gradient(107.56deg, ${cb.color.faction_bg} 0%, #000000 100%)`,
		);
		$('.stat .icon').css(
			'background',
			`radial-gradient(
			97.53% 108.2% at 50% 50%,
			rgba(${cb.color.rgb.r}, ${cb.color.rgb.g}, ${cb.color.rgb.b}, 0.25) 0%,
			rgba(${cb.color.rgb.r}, ${cb.color.rgb.g}, ${cb.color.rgb.b}, 0) 100%)`,
		);
		$('.options .option').css('--hover-bg', cb.color.circle_fill);
		$('.hitmarker .item').css({
			'--hover-border-item': cb.color.circle_fill,
			'--hover-bg-item': cb.color.circle_bg,
		});
		$('.stat .icon, .booster .profile').css({
			borderColor: cb.color.circle_fill,
			filter: `drop-shadow(0 0 1.39vh rgba(${cb.color.rgb.r}, ${cb.color.rgb.g}, ${cb.color.rgb.b}, 0.35))`,
		});
		$('.hitmarker .columns .column .title').css({
			'--hover-border-hit': cb.color.circle_bg,
			'--hover-bg-hit': `radial-gradient(
				999.11% 221.5% at 50% 50%,
				rgba(${cb.color.rgb.r}, ${cb.color.rgb.g}, ${cb.color.rgb.b}, 0.5) 0%,
				rgba(${cb.color.rgb.r}, ${cb.color.rgb.g}, ${cb.color.rgb.b}, 0) 91.09%
			)`,
		});
		$('.pausemenu_container .row .right > div > .title').css({
			color: cb.color.circle_fill,
			textShadow: `0 0.4vh 3.334vh rgba(${cb.color.rgb.r}, ${cb.color.rgb.g}, ${cb.color.rgb.b}, 0.55)`,
		});
		for (var i = 0; i < cb.clothes.outfits.length; i++) {
			window.postMessage({
				action: 'AppendClothing',
				label: `OUTFIT ${i + 1}`,
				index: i + 1,
				color: cb.color,
			});
		}
	});
};

const SelectClothing = (id) => {
	firstTime = false;
	$('.faction_container').fadeOut(300);
	$.post(
		`https://${GetParentResourceName()}/SelectClothing`,
		JSON.stringify({
			id: id,
			team: team,
		}),
	);
	setTimeout(() => {
		$('.factions').show();
		$('.faction_clothing').hide().empty();
	}, 300);
};

const setSVG = (percent, src) => {
	const interval = setInterval(() => {
		var progressCircle = document.querySelector(src);
		if (progressCircle) {
			const circumference = progressCircle.r.baseVal.value * 2 * Math.PI;
			progressCircle.style.strokeDashoffset =
				circumference - (percent / 100) * circumference;
			clearInterval(interval);
		}
	}, 10);
};

const ToggleWeapon = (weapon, checked) => {
	SETTINGS.Weapons[weapon] = checked;
	SaveSettings();
};

const CollectReward = (index, type) => {
	$.post(
		`https://${GetParentResourceName()}/CollectReward`,
		JSON.stringify({
			index: index,
			type: type,
		}),
	).then((resp) => {
		if (resp.success) {
			$(`#${type}_${index}`)
				.removeClass('can')
				.addClass('collected')
				.removeAttr('onclick');
		}
	});
};

const SetLoadout = (loadout, meta) => {
	$('.weapons .grid').empty();
	for (const weaponName in loadout) {
		if (meta[weaponName]) {
			$('.weapons .grid').append(`<div class="item">
				<div class="title">
					<h2>${meta[weaponName].type}</h2>
					<h1>${meta[weaponName].label}</h1>
				</div>
				<img src="assets/img/items/${weaponName}.png"
					onerror="this.src = 'https://cdn.icon-icons.com/icons2/945/PNG/512/Office_-12_icon-icons.com_73953.png'">
				<label class="checkbox">
					<input
						type="checkbox"
						${
							SETTINGS.Weapons[weaponName] == true
								? 'checked'
								: SETTINGS.Weapons[weaponName] == undefined
								? 'checked'
								: ''
						}
						oninput="ToggleWeapon('${weaponName}', this.checked)"
					>
					<div class="input"></div>
				</label>
			</div>`);
		}
	}
};

const SetBattlepass = (rewards, collected, prefix) => {
	for (let index = 0; index < rewards.length; index++) {
		const reward = rewards[index];
		const indexString = `${index + 1}`;
		$(`.bp-row.${prefix} .rewards`).append(`<div class="reward ${
			collected[prefix][indexString]
				? 'collected'
				: reward.level <= level
				? 'can'
				: ''
		}" ${
			!collected[prefix][indexString] && reward.level < level
				? `onclick="CollectReward(${index + 1}, '${prefix}')"`
				: ''
		} id="${prefix}_${index + 1}">
			<h1 class="title">LEVEL ${reward.level}</h1>
			<div class="info">
				<img src="assets/img/items/${reward.name}.png">
				<h1>${reward.label}</h1>
			</div>
		</div>`);
	}
};
