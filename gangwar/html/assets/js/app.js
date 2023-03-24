window.onload = () => {
    window.addEventListener('keydown', e => {
        switch(e.keyCode) {
            case 27:
                $.post(`https://${GetParentResourceName()}/close`)
            break
        }
    })
    window.addEventListener('message', e => {
        var i = e.data
        switch (i.action) {
            case 'AppendFrak': {
                const html = $(`<div class="faction flex_column_space grid_item">
                    <div>
                        <div class="faction_logo flex_centered">
                            <img class="blur" src="assets/img/factions/${i.name}.png">
                            <img src="assets/img/factions/${i.name}.png">
                        </div>
                        <div class="label akr_bold">${i.label}</div>
                        <div class="faction_info flex_row_align">
                            <div class="circle flex_centered radius_50">
                                <div class="inner radius_50"></div>
                            </div>
                            <div class="flex_row_align_bottom">
                                <div class="font_15 akr_bold">${i.player}</div>
                                <div class="font_10 akr_light">SPIELER ONLINE</div>
                            </div>
                        </div>
                    </div>
                    <button class="button_border_1 akr_bold font_15" style="
                    --bg: ${i.color.bg};
                    --border: ${i.color.border};
                    --hover: ${i.color.hover};
                    ">AUSWÄHLEN</button>
                </div>`)
            }
        }
    })
}