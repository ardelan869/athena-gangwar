var team = undefined
var firstTime = true
var level = 0
const messages = []
var messageIndex = -1

window.onload = () => {
    window.addEventListener('keydown', e => {
        switch (e.keyCode) {
            case 27:
                if (!firstTime) {
                    $('.faction_container').fadeOut(300)
                    $.post(`https://${GetParentResourceName()}/close`)
                    setTimeout(() => {
                        $('.factions').show()
                        $('.faction_clothing').hide()
                    }, 300)
                }
            break
        }
    })
    document.getElementById('chat').addEventListener('keydown', e => {
        switch (e.keyCode) {
            case 27:
                $.post(`https://${GetParentResourceName()}/close`)
                $('.chat').hide()
                setTimeout(() => {
                    if ($('.chat').css('display') == 'none') $('.messages').hide();
                }, 3500)
            break
            case 13:
                const message = $('.chat').val()
                if (message.length > 1) {
                    $.post(`https://${GetParentResourceName()}/chat`, JSON.stringify({
                        message:message
                    }))
                    messages.push(message)
                }
                $('.chat').val('').hide()
                setTimeout(() => {
                    if ($('.chat').css('display') == 'none') $('.messages').hide();
                }, 3500)
            break
            case 38: // up
                if (messages[0] && messageIndex != messages.length-1) {
                    messageIndex++
                    $('.chat').val(messages[(messages.length-1)-messageIndex])
                }
            break
            case 40: // down
                if (messages[0] && messageIndex-1 > -1) {
                    messageIndex--
                    $('.chat').val(messages[(messages.length-1)-messageIndex])
                } else {
                    messageIndex = -1
                    $('.chat').val('')
                }
            break
        }
    })
    window.addEventListener('message', e => {
        var i = e.data
        switch (i.action) {
            case 'UpdateTeamCount':
                $(`#${i.team}_count`).text(i.count)
            break
            case 'AppendFrak':
                const html = $(`<div class="faction flex_column_space grid_item">
                    <div style="--img-border: ${i.color.img_border};">
                        <div class="faction_logo flex_centered">
                            <img class="blur" src="assets/img/factions/${i.name}.png">
                            <img src="assets/img/factions/${i.name}.png">
                        </div>
                        <div class="label akr_bold" style="
                        --label-bg: ${i.color.label_bg};
                        --label-color: ${i.color.label_color};
                        ">${i.label}</div>
                        <div class="faction_info flex_row_align">
                            <div class="circle flex_centered radius_50" style="
                            --circle-bg: ${i.color.circle_bg};
                            --circle-border: ${i.color.circle_border};
                            --circle-fill: ${i.color.circle_fill};
                            ">
                                <div class="inner radius_50"></div>
                            </div>
                            <div class="flex_row_align_bottom">
                                <div class="font_15 akr_bold" id="${i.name}_count">0</div>
                                <div class="font_10 akr_light">SPIELER ONLINE</div>
                            </div>
                        </div>
                    </div>
                    <button class="button_border_1 akr_bold font_15" style="
                    --bg: ${i.color.bg};
                    --border: ${i.color.border};
                    --border-hover: ${i.color.border_hover};
                    --hover: ${i.color.hover};
                    " onclick="SelectFaction('${i.name}')">AUSWÄHLEN</button>
                </div>`).appendTo('.factions .grid_4')
            break
            case 'AppendClothing':
                $(`<div class="clothing flex_column_space">
                    <div class="flex_column_centered" style="
                    --img-border: ${i.color.img_border};
                    ">
                        <img src="assets/img/outfits/cloth.png">
                        <div class="label akr_bold" style="
                        --label-bg: ${i.color.label_bg};
                        --label-color: ${i.color.label_color};
                        ">${i.label}</div>
                    </div>
                    <button class="akr_bold font_15 button_border_1" style="
                    --bg: ${i.color.bg};
                    --border: ${i.color.border};
                    --border-hover: ${i.color.border_hover};
                    --hover: ${i.color.hover};
                    " onclick="SelectClothing(${i.index})">AUSWÄHLEN</button>
                </div>`).appendTo('.faction_clothing')
            break
            case 'AddQuest':
                const svgID = document.querySelectorAll('.quest').length+1
                const quest = $(`<div class="quest flex_row_align">
                    <svg class="svg_circle" id="svg_${svgID}" viewBox="0 0 60 60">
                        <text x="30" y="38" style="font-size: 22;" class="akr_xbold">${i.progress}/${i.max}</text>
                        <circle bar cx="30" cy="30" r="25"></circle>
                        <circle prog cx="30" cy="30" r="25"></circle>
                    </svg>
                    <h1 class="akr_semi font_15">${i.quest}</h1>
                </div>`).appendTo('.quests')
            break
            case 'AddNotify':
                const element = $(`<div class="animation-toLeft notification">
                    <div class="blur"></div>
                    <div class="flex_row_align">
                        <img src="assets/img/icons/${i.icon}.png">
                        <div class="flex_row_align_bottom double_font_2">
                            <h1 class="shl font_36 font_white_15">${i.title}</h1>
                            <h2 class="akr_xbold font_20">${i.title}</h2>
                        </div>
                    </div>
                    <div class="font_15 akr_semi">
                        ${i.text}
                    </div>
                </div>`).appendTo('.notifications')
                setTimeout(() => {
                    element.animate({
                        height: '0vh'
                    }, 300).fadeOut(300)
                    setTimeout(() => element.remove(), 250)
                }, i.time-250)
            break
            case 'AddAnnounce': {
                const element = $(`<div class="announce flex_column_centered_h animation-toLeft">
                    <div class="flex_row_align">
                        <div class="flex_row_align">
                            <div class="point s"></div>
                            <div class="point m"></div>
                            <div class="point l"></div>
                        </div>
                        <div class="double_font flex_row_centered">
                            <div class="akr_xbold font_36">${i.title}</div>
                            <div class="shl font_46 font_white_15">${i.title}</div>
                        </div>
                        <div class="flex_row_align">
                            <div class="point l"></div>
                            <div class="point m"></div>
                            <div class="point s"></div>
                        </div>
                    </div>
                    <div class="font_20 akr">${i.text}</div>
                </div>`).appendTo('.announces')
                setTimeout(() => {
                    element.fadeOut(300)
                    setTimeout(() => element.remove(), 300)
                }, i.time)
                break
            }
            case 'ToggleSpeedo':
                if (i.bool) {
                    $('.speedo').fadeIn()
                    $('#speed').text(addSpeed(i.speed))
                } else $('.speedo').fadeOut()
            break
            case 'CopyCoords':
                const el = document.createElement('textarea');
                el.value = i.coords;
                document.body.appendChild(el);
                el.select();
                document.execCommand('copy');
                document.body.removeChild(el);
            break
            case 'Bar':
                $('.progressbar').show()
                const prog = $('#progress')
                if (i.time == 0) {
                    prog.stop()
                    $('#percent').text('ABBGEBROCHEN')
                    prog.css({
                        background: '#FF3030',
                        boxShadow: '0 0 1vh #FF3030'
                    })
                    $('.progressbar').fadeOut(550)
                    setTimeout(() => {
                        prog.css('width', 0)
                        $('#percent').text('')
                    }, 550)
                } else prog.stop().css({
                    width: 0,
                    background: '#FFF',
                    boxShadow: '0 0 1vh rgba(255, 255, 255, 1)'
                }).animate({width: '100%'}, {
					duration: i.time,
					progress: (event, progress) => $('#percent').text(`${Math.floor(progress*100)} %`),
					complete: () => {
                        prog.stop()
                        $('#percent').text('FERTIG')
                        prog.css({
                            background: '#A1F438',
                            boxShadow: '0 0 1vh #A1F438'
                        })
                        $('.progressbar').fadeOut(550)
                        setTimeout(() => {
                            prog.css('width', 0)
                            $('#percent').text('')
                        }, 550)
					}
				});
            break
            case 'SetId':
                $('#playerId').text(`#${i.id}`)
                $('#level').text(i.level)
                $('#xp').html(`${i.xp}<font class="font_white_5 font_15 akr_xbold">/${i.needed}XP</font>`)
                setSVG((i.xp/i.needed) * 100, '#level-progress')
                level = i.level
            break
            case 'ShowHitmarker':
                $('#crosshair, #damage').show()
                if (i.deadly) {
                    $('#damage').text('KILL')
                    $('#crosshair > path, #damage').css({
                        color: '#F00',
                        fill: '#F00'
                    })
                } else $('#damage').text(i.damage)
                setTimeout(() => {
                    $('#crosshair').hide()
                    $('#crosshair > path, #damage').css({
                        color: '#FFF',
                        fill: '#FFF'
                    })
                    setTimeout(() => $('#damage').hide(), 100)
                }, 250);
            break
            case 'AddXPFeed':
                if (level && i.level != level) {
                    var sound = new Audio('assets/audio/levelup.mp3')
                    sound.volume = 1
                    sound.play()
                }
                level = i.level
                $('#level').text(i.level)
                $('#xp').html(`${i.xp}<font class="font_white_5 font_15 akr_xbold">/${i.needed}XP</font>`)
                setSVG((i.xp/i.needed) * 100, '#level-progress')
                const prefix = {
                    ['subtract']: '-',
                    ['add']: '+',
                }
                const xpFeed = $(`<div class="animation-toTop xp ${i.type} flex_row_align">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M15.2 7.2H14.344C14.1654 5.79198 13.5239 4.48326 12.5203 3.47967C11.5167 2.47608 10.208 1.83455 8.8 1.656V0.8C8.8 0.587827 8.71571 0.384344 8.56569 0.234315C8.41566 0.0842854 8.21217 0 8 0C7.78783 0 7.58434 0.0842854 7.43431 0.234315C7.28429 0.384344 7.2 0.587827 7.2 0.8V1.656C5.79198 1.83455 4.48326 2.47608 3.47967 3.47967C2.47608 4.48326 1.83455 5.79198 1.656 7.2H0.8C0.587827 7.2 0.384344 7.28429 0.234315 7.43431C0.0842854 7.58434 0 7.78783 0 8C0 8.21217 0.0842854 8.41566 0.234315 8.56569C0.384344 8.71571 0.587827 8.8 0.8 8.8H1.656C1.83455 10.208 2.47608 11.5167 3.47967 12.5203C4.48326 13.5239 5.79198 14.1654 7.2 14.344V15.2C7.2 15.4122 7.28429 15.6157 7.43431 15.7657C7.58434 15.9157 7.78783 16 8 16C8.21217 16 8.41566 15.9157 8.56569 15.7657C8.71571 15.6157 8.8 15.4122 8.8 15.2V14.344C10.208 14.1654 11.5167 13.5239 12.5203 12.5203C13.5239 11.5167 14.1654 10.208 14.344 8.8H15.2C15.4122 8.8 15.6157 8.71571 15.7657 8.56569C15.9157 8.41566 16 8.21217 16 8C16 7.78783 15.9157 7.58434 15.7657 7.43431C15.6157 7.28429 15.4122 7.2 15.2 7.2ZM12 8.8H12.728C12.5613 9.78116 12.0937 10.6862 11.39 11.39C10.6862 12.0937 9.78116 12.5613 8.8 12.728V12C8.8 11.7878 8.71571 11.5843 8.56569 11.4343C8.41566 11.2843 8.21217 11.2 8 11.2C7.78783 11.2 7.58434 11.2843 7.43431 11.4343C7.28429 11.5843 7.2 11.7878 7.2 12V12.728C6.21884 12.5613 5.31377 12.0937 4.61005 11.39C3.90632 10.6862 3.43873 9.78116 3.272 8.8H4C4.21217 8.8 4.41566 8.71571 4.56569 8.56569C4.71571 8.41566 4.8 8.21217 4.8 8C4.8 7.78783 4.71571 7.58434 4.56569 7.43431C4.41566 7.28429 4.21217 7.2 4 7.2H3.272C3.43873 6.21884 3.90632 5.31377 4.61005 4.61005C5.31377 3.90632 6.21884 3.43873 7.2 3.272V4C7.2 4.21217 7.28429 4.41566 7.43431 4.56569C7.58434 4.71571 7.78783 4.8 8 4.8C8.21217 4.8 8.41566 4.71571 8.56569 4.56569C8.71571 4.41566 8.8 4.21217 8.8 4V3.272C9.78116 3.43873 10.6862 3.90632 11.39 4.61005C12.0937 5.31377 12.5613 6.21884 12.728 7.2H12C11.7878 7.2 11.5843 7.28429 11.4343 7.43431C11.2843 7.58434 11.2 7.78783 11.2 8C11.2 8.21217 11.2843 8.41566 11.4343 8.56569C11.5843 8.71571 11.7878 8.8 12 8.8ZM8 7.2C7.84177 7.2 7.6871 7.24692 7.55554 7.33482C7.42398 7.42273 7.32145 7.54767 7.2609 7.69385C7.20035 7.84003 7.1845 8.00089 7.21537 8.15607C7.24624 8.31126 7.32243 8.4538 7.43431 8.56569C7.5462 8.67757 7.68874 8.75376 7.84393 8.78463C7.99911 8.8155 8.15997 8.79965 8.30615 8.7391C8.45233 8.67855 8.57727 8.57602 8.66518 8.44446C8.75308 8.3129 8.8 8.15823 8.8 8C8.8 7.78783 8.71571 7.58434 8.56569 7.43431C8.41566 7.28429 8.21217 7.2 8 7.2Z"/>
                    </svg>
                    <span class="akr_semi font_15">${prefix[i.type]}${i.amount}XP</span>
                    <font class="akr_semi font_15 font_white_25">(${i.reason})</font>
                </div>`).appendTo('#xp-list')
                setTimeout(() => {
                    xpFeed.fadeOut(300)
                    setTimeout(() => xpFeed.remove(), 300)
                }, 1700)
            break
            case 'ToggleHUD':
                if (i.bool) $('.hud').show()
                else $('.hud').hide()
            break
            case 'ToggleFraction':
                if (i.bool) {
                    $('.faction_container, .factions').show()
                    $('.faction_clothing').hide()
                } else $('.faction_container').hide()
            break
            case 'UpdatePlayers':
                $('#players').text(i.players)
            break
            case 'SetStats':
                $('#kills').text(i.kills)
                $('#deaths').text(i.deaths)
                var kd = i.kills / i.deaths
                if (typeof kd != 'number') kd = i.kills;
                $('#kd').text(kd.toFixed(2))
            break
            case 'AddMessage':
                const message = $(`<div class="message akr_semi font_20">
                    [<font style="color: ${i.color};">${_U(i.rank)}</font>] [${i.id}] ${i.name}: ${i.text}
                </div>`).appendTo('.messages')
                setTimeout(() => {
                    if ($('.chat').css('display') == 'none') $('.messages').hide();
                }, 3500)
            break
            case 'OpenChat':
                $('.chat, .messages').show()
                $('.chat').focus()
            break
        }
    })
    setInterval(() => {
        const date = new Date
        $('#time').text(`${addZero(date.getHours())}:${addZero(date.getMinutes())}`)
        $('#date').text(`${addZero(date.getDate())}.${addZero(date.getMonth()+1)}.${date.getFullYear()}`)
    }, 500)
}

const _U = s => {
    return s.charAt(0).toUpperCase() + s.slice(1);
}

const addZero = int => {
    if (int < 10) return '0'+int
    else return int
}

const addSpeed = (speed) => {
    if (speed === 0) return speed = '000';
    else if (speed.toString().length <= 1) return '00' + speed;
    else if (speed.toString().length <= 2) return '0' + speed;
    return speed;
}

const SelectFaction = name => {
    team = name
    $('.factions').hide()
    $('.faction_clothing').show()
    $.post(`https://${GetParentResourceName()}/FetchClothing`, JSON.stringify({
        team: name
    })).then(cb => {
        for (var i = 0; i < cb.clothes.length; i++) {
            window.postMessage({
                action: 'AppendClothing',
                label: `OUTFIT ${i+1}`,
                index: i+1,
                color: cb.color
            })
        }
    })
}

const SelectClothing = id => {
    firstTime = false
    $('.faction_container').fadeOut(300)
    $.post(`https://${GetParentResourceName()}/SelectClothing`, JSON.stringify({
        id: id,
        team: team
    }))
    setTimeout(() => {
        $('.factions').show()
        $('.faction_clothing').hide().empty()
    }, 300)
}

const setSVG = (percent, src) => {
	var progressCircle = document.querySelector(src);
	const circumference = progressCircle.r.baseVal.value * 2 * Math.PI;
	progressCircle.style.strokeDashoffset = circumference - (percent / 100) * circumference;
}