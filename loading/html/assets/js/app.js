const Config = [
    {
        path: 'assets/audio/athena.mp3',
        label: 'Hoodblaq - Athena'
    },
    {
        path: 'assets/audio/conan.mp3',
        label: 'Haftbefehl x Shirin David - Conan'
    },
    {
        path: 'assets/audio/radw.mp3',
        label: 'Haftbefehl - RADW'
    },
];
var sound;
var soundIndex = 0;
var volume = 0.1;

window.addEventListener('DOMContentLoaded', () => {
    const data = window.nuiHandoverData;
    if (!data) return;
    document.getElementById('static').innerText = data.static;
    document.getElementById('players').innerHTML = data.players;
    document.getElementById('level').innerText = data.level;
    document.getElementById('kd').innerText = data.kd.toFixed(2);
    document.getElementById('kills').innerText = data.kills;
    document.getElementById('deaths').innerText = data.deaths;
});

const toggle = () => {
    if (sound.paused) sound.play();
    else sound.pause();
    const icon = (sound.paused == false) ? 'pause' : 'play';
    document.getElementById('play-img').src = `assets/img/${icon}.svg`;
};

const play = () => {
    if (sound) sound.pause();
    sound = new Audio();
    sound.src = Config[soundIndex].path;
    sound.play();
    sound.volume = volume;
    document.getElementById('title').innerText = Config[soundIndex].label;
};

window.onload = () => {
    play();

    document.getElementById('play-btn').addEventListener('click', toggle);
    window.addEventListener('keydown', e => {
        if (e.which == 32) toggle();
    });

    document.getElementById('arrow_l').addEventListener('click', e => {
        if (soundIndex > 0) {
            soundIndex--;
            play();
        };
    });

    document.getElementById('arrow_r').addEventListener('click', e => {
        if (soundIndex < Config.length - 1) {
            soundIndex++;
            play();
        };
    });

    const slider = document.getElementById('range')

    slider.addEventListener('input', e => {
        const val = (slider.value / 100).toFixed(2)
        volume = val;
        sound.volume = val;
    })
}

window.addEventListener('message', function (e) {
    if (e.data.eventName === 'loadProgress') {
        const per = parseInt(e.data.loadFraction * 100);
        document.getElementById('percent').innerText = `${Math.floor(per)}%`;
        document.getElementById('progress').style.width = `${per}%`;
    };
});