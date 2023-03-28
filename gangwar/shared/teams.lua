Teams = {
    ['bloods'] = {
        name = 'bloods',
        label = 'NINE TREY BLOODS',
        spawn = vector3(-64.15639, -1449.646, 32.52497),
        clothing = vector3(-61.13043, -1450.227, 32.12366),
        garage = {
            pos = vector3(-59.41166, -1460.058, 31.97334),
            spawns = {
                vector4(-57.5259, -1465.733, 32.15617, 108.8589)
            }
        },
        color = {
            rgb = {
                r = 255,
                g = 48,
                b = 48
            },
            bg = 'rgba(255, 48, 48, 0.15)',
            border = 'rgba(255, 48, 48, 0.25)',
            border_hover = 'rgba(255, 48, 48, 0.5)',
            img_border = '#FF3030',
            label_bg = 'rgba(255, 48, 48, 0.25)',
            label_color = '#FF3030',
            hover = 'linear-gradient(90deg, rgba(255, 48, 48, 0.25) 0%, rgba(255, 48, 48, 0.5) 50.23%, rgba(255, 48, 48, 0.25) 100%)',
            circle_bg = 'rgba(255, 48, 48, 0.25)',
            circle_border = 'rgba(255, 48, 48, 0.5)',
            circle_fill = '#FF3030',
            faction_bg = '#6b1818',
            blip = 1
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 305,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 5,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 118,
                        textureId = 9,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 79,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 5,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 111,
                        textureId = 5,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 134,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 5,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 118,
                        textureId = 9,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'T-Shirt Maske',
                        drawable = 118,
                        texture = 9,
                    },
                    {
                        label = 'Rote Maske',
                        drawable = 111,
                        texture = 5,
                    }
                },
                ['pants'] = {
                    {
                        label = 'Jogger',
                        drawable = 5,
                        texture = 5
                    },
                    {
                        label = 'Karro Shorts',
                        drawable = 16,
                        texture = 1
                    },
                    {
                        label = 'Bademantel',
                        drawable = 56,
                        texture = 3
                    },
                    {
                        label = 'Versace Bademantel',
                        drawable = 119,
                        texture = 1
                    },
                    {
                        label = 'Herzen Unterhose',
                        drawable = 61,
                        texture = 6
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Weisser Pullover',
                        drawable = 305,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Pullover',
                        drawable = 305,
                        texture = 1
                    },
                    {
                        label = 'Schwarzer Rollkrage',
                        drawable = 111,
                        texture = 3
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                    {
                        label = 'Rote Crocs',
                        drawable = 112,
                        texture = 8
                    },
                    {
                        label = 'Schwarze MSCHF',
                        drawable = 118,
                        texture = 0
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['mg13'] = {
        name = 'mg13',
        label = 'MARABUNTA GRANDE 13',
        spawn = vector3(1286.475, -1603.841, 54.82489),
        clothing = vector3(1284.094, -1603.379, 54.82496),
        garage = {
            pos = vector3(1288.573, -1602.126, 54.82496),
            spawns = {
                vector4(1290.857, -1577.146, 51.35234, 301.2345)
            }
        },
        color = {
            rgb = {
                r = 0,
                g = 198,
                b = 238
            },
            bg = 'rgba(0, 198, 238, 0.15)',
            border = 'rgba(0, 198, 238, 0.25)',
            border_hover = 'rgba(0, 198, 238, 0.5)',
            img_border = '#00C6EE',
            label_bg = 'rgba(0, 198, 238, 0.25)',
            label_color = '#00C6EE',
            hover = 'linear-gradient(90deg, rgba(0, 198, 238, 0.25) 0%, rgba(0, 198, 238, 0.5) 50.23%, rgba(0, 198, 238, 0.25) 100%)',
            circle_bg = 'rgba(0, 198, 238, 0.25)',
            circle_border = 'rgba(0, 198, 238, 0.5)',
            circle_fill = '#00C6EE',
            faction_bg = '#07768c',
            blip = 3
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 96,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 3,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 134,
                        textureId = 1,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 3,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 134,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 3,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Bandana Maske',
                        drawable = 111,
                        texture = 4
                    },
                    {
                        label = 'Tuch Maske',
                        drawable = 5,
                        texture = 3
                    },
                    {
                        label = 'Voll Maske',
                        drawable = 115,
                        texture = 7
                    },
                },
                ['pants'] = {
                    {
                        label = 'Blaue Jogger',
                        drawable = 5,
                        texture = 3
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Blauer Kapuzenpullover',
                        drawable = 96,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Rollkragen',
                        drawable = 111,
                        texture = 3
                    },
                    {
                        label = 'Roter Bravo Pullover',
                        drawable = 134,
                        texture = 1
                    },
                    {
                        label = 'Weisses T-Shirt',
                        drawable = 273,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Kapuzenpullover',
                        drawable = 134,
                        texture = 0
                    },
                    {
                        label = 'Unterhemd',
                        drawable = 237,
                        texture = 0
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Yacht Schuhe',
                        drawable = 92,
                        texture = 1
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                    {
                        label = 'Blaue Crocs',
                        drawable = 112,
                        texture = 15
                    },
                    {
                        label = 'Schwarze MSCHF',
                        drawable = 118,
                        texture = 0
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                    {
                        label = 'Blauer Hut',
                        drawable = 64,
                        texture = 5
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['vagos'] = {
        name = 'vagos',
        label = 'LOS SANTOS VAGOS',
        spawn = vector3(-1128.811, -1605.771, 4.398428),
        clothing = vector3(-1119.984, -1624.447, 4.398428),
        garage = {
            pos = vector3(-1121.494, -1614.488, 4.398431),
            spawns = {
                vector4(-1119.959, -1602.771, 4.398426, 32.65443)
            }
        },
        color = {
            rgb = {
                r = 255,
                g = 255,
                b = 51
            },
            bg = 'rgba(255, 255, 51, 0.15)',
            border = 'rgba(255, 255, 51, 0.25)',
            border_hover = 'rgba(255, 255, 51, 0.5)',
            img_border = '#FFF333',
            label_bg = 'rgba(255, 255, 51, 0.25)',
            label_color = '#FFF333',
            hover = 'linear-gradient(90deg, rgba(255, 255, 51, 0.25) 0%, rgba(255, 255, 51, 0.5) 50.23%, rgba(255, 255, 51, 0.25) 100%)',
            circle_bg = 'rgba(255, 255, 51, 0.25)',
            circle_border = 'rgba(255, 255, 51, 0.5)',
            circle_fill = '#FFF333',
            faction_bg = '#a1991b',
            blip = 5
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 96,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 16,
                        textureId = 2,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 134,
                        textureId = 1,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 119,
                        textureId = 3,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 111,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 18,
                        textureId = 10,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Bandana Maske',
                        drawable = 16,
                        texture = 2
                    },
                    {
                        label = 'Clown Maske',
                        drawable = 95,
                        texture = 0
                    },
                    {
                        label = 'Sturmhaube',
                        drawable = 57,
                        texture = 0
                    },
                },
                ['pants'] = {
                    {
                        label = 'Gelbe Shorts',
                        drawable = 16,
                        texture = 2
                    },
                    {
                        label = 'Gelber Jogger',
                        drawable = 16,
                        texture = 8
                    },
                    {
                        label = 'Gelbe Unterhose',
                        drawable = 18,
                        texture = 0
                    },
                    {
                        label = 'Leoparden Unterhose',
                        drawable = 18,
                        texture = 10
                    },
                    {
                        label = 'Bademantel',
                        drawable = 119,
                        texture = 3
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Blauer Bravo Pulli',
                        drawable = 96,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Rollkragen',
                        drawable = 111,
                        texture = 3
                    },
                    {
                        label = 'Roter Bravo Pulli',
                        drawable = 134,
                        texture = 1
                    },
                    {
                        label = 'Weisses T-Shirt',
                        drawable = 273,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Kapuzenpullover',
                        drawable = 134,
                        texture = 0
                    },
                    {
                        label = 'Unterhemd',
                        drawable = 237,
                        texture = 0
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Yacht Schuhe',
                        drawable = 92,
                        texture = 4
                    },
                    {
                        label = 'Yacht Schuhe mit Muster',
                        drawable = 95,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                    {
                        label = 'Gelbe Crocs',
                        drawable = 112,
                        texture = 10
                    },
                    {
                        label = 'Schwarze MSCHF',
                        drawable = 118,
                        texture = 0
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['ballas'] = {
        name = 'ballas',
        label = 'BALLAS',
        spawn = vector3(90.5061, -1954.084, 20.84047),
        clothing = vector3(85.80161, -1959.369, 21.12169),
        garage = {
            pos = vector3(103.1882, -1958.681, 20.78538),
            spawns = {
                vector4(105.608, -1940.868, 20.80372, 47.85389)
            }
        },
        color = {
            rgb = {
                r = 150,
                g = 35,
                b = 239
            },
            bg = 'rgba(150, 35, 239, 0.15)',
            border = 'rgba(150, 35, 239, 0.25)',
            border_hover = 'rgba(150, 35, 239, 0.5)',
            img_border = '#9623EF',
            label_bg = 'rgba(150, 35, 239, 0.25)',
            label_color = '#9623EF',
            hover = 'linear-gradient(90deg, rgba(150, 35, 239, 0.25) 0%, rgba(150, 35, 239, 0.5) 50.23%, rgba(150, 35, 239, 0.25) 100%)',
            circle_bg = 'rgba(150, 35, 239, 0.25)',
            circle_border = 'rgba(150, 35, 239, 0.5)',
            circle_fill = '#9623EF',
            faction_bg = '#47166e',
            blip = 27
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 171,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 9,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 111,
                        textureId = 2,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 139,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 9,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 115,
                        textureId = 24,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 111,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 9,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 118,
                        textureId = 2,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Bandana Maske',
                        drawable = 51,
                        texture = 6
                    },
                    {
                        label = 'Sturmhaube',
                        drawable = 57,
                        texture = 0
                    },
                    {
                        label = 'Voll Maske',
                        drawable = 115,
                        texture = 24
                    },
                },
                ['pants'] = {
                    {
                        label = 'Lila Jogger',
                        drawable = 5,
                        texture = 9
                    },
                    {
                        label = 'Lila Shorts',
                        drawable = 15,
                        texture = 8
                    },
                    {
                        label = 'Lila Shorts 2',
                        drawable = 16,
                        texture = 5
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Schwarzer Rollkragen',
                        drawable = 111,
                        texture = 3
                    },
                    {
                        label = 'Roter Bravo Pulli',
                        drawable = 134,
                        texture = 1
                    },
                    {
                        label = 'Weisses T-Shirt',
                        drawable = 273,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Kapuzenpullover',
                        drawable = 134,
                        texture = 0
                    },
                    {
                        label = 'Unterhemd',
                        drawable = 237,
                        texture = 0
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['grove'] = {
        name = 'grove',
        label = 'GROVE STREET',
        spawn = vector3(1385.321, -592.7568, 74.48544),
        clothing = vector3(1367.308, -605.4401, 74.71092),
        garage = {
            pos = vector3(1379.417, -600.4548, 74.33796),
            spawns = {
                vector4(1373.852, -592.7572, 74.37379, 38.56346)
            }
        },
        color = {
            rgb = {
                r = 24,
                g = 213,
                b = 24
            },
            bg = 'rgba(24, 213, 24, 0.15)',
            border = 'rgba(24, 213, 24, 0.25)',
            border_hover = 'rgba(24, 213, 24, 0.5)',
            img_border = '#18D518',
            label_bg = 'rgba(24, 213, 24, 0.25)',
            label_color = '#18D518',
            hover = 'linear-gradient(90deg, rgba(24, 213, 24, 0.25) 0%, rgba(24, 213, 24, 0.5) 50.23%, rgba(24, 213, 24, 0.25) 100%)',
            circle_bg = 'rgba(24, 213, 24, 0.25)',
            circle_border = 'rgba(24, 213, 24, 0.5)',
            circle_fill = '#18D518',
            faction_bg = '#0e7d0e',
            blip = 2
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 171,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 6,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 51,
                        textureId = 5,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 139,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 6,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 111,
                        textureId = 5,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 111,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 6,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 118,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Bandana Maske',
                        drawable = 51,
                        texture = 5
                    },
                    {
                        label = 'Bandana Maske 2',
                        drawable = 111,
                        texture = 5
                    },
                    {
                        label = 'Sturmhaube',
                        drawable = 57,
                        texture = 0
                    },
                    {
                        label = 'Voll Maske',
                        drawable = 115,
                        texture = 22
                    },
                    {
                        label = 'Tuch Maske',
                        drawable = 118,
                        texture = 0
                    },
                },
                ['pants'] = {
                    {
                        label = 'Grüne Shorts',
                        drawable = 16,
                        texture = 4
                    },
                    {
                        label = 'Grüner Jogger',
                        drawable = 5,
                        texture = 6
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Schwarzer Rollkragen',
                        drawable = 111,
                        texture = 3
                    },
                    {
                        label = 'Roter Bravo Pulli',
                        drawable = 134,
                        texture = 1
                    },
                    {
                        label = 'Weisses T-Shirt',
                        drawable = 273,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Kapuzenpullover',
                        drawable = 134,
                        texture = 0
                    },
                    {
                        label = 'Grüner Schlafanzug',
                        drawable = 117,
                        texture = 5
                    },
                    {
                        label = 'Unterhemd',
                        drawable = 237,
                        texture = 0
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['yakuza'] = {
        name = 'yakuza',
        label = 'YAKUZA',
        spawn = vector3(-1526.485, 849.9528, 181.5947),
        clothing = vector3(-1516.651, 851.9207, 181.5947),
        garage = {
            pos = vector3(-1516.294, 860.2698, 181.9504),
            spawns = {
                vector4(-1519.763, 866.1485, 181.7014, 348.6514)
            }
        },
        color = {
            rgb = {
                r = 255,
                g = 0,
                b = 0
            },
            bg = 'rgba(255, 0, 0, 0.15)',
            border = 'rgba(255, 0, 0, 0.25)',
            border_hover = 'rgba(255, 0, 0, 0.5)',
            img_border = '#FF0000',
            label_bg = 'rgba(255, 0, 0, 0.25)',
            label_color = '#FF0000',
            hover = 'linear-gradient(90deg, rgba(255, 0, 0, 0.25) 0%, rgba(255, 0, 0, 0.5) 50.23%, rgba(255, 0, 0, 0.25) 100%)',
            circle_bg = 'rgba(255, 0, 0, 0.25)',
            circle_border = 'rgba(255, 0, 0, 0.5)',
            circle_fill = '#FF0000',
            faction_bg = '#6e0909',
            blip = 6
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 171,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 24,
                        textureId = 4,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 118,
                        textureId = 9,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 139,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 24,
                        textureId = 4,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 111,
                        textureId = 5,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 111,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 24,
                        textureId = 4,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 94,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'T-Shirt Maske',
                        drawable = 118,
                        texture = 9,
                    },
                    {
                        label = 'Rote Maske',
                        drawable = 111,
                        texture = 5,
                    },
                    {
                        label = 'Teufel Maske',
                        drawable = 94,
                        texture = 0,
                    },
                },
                ['pants'] = {
                    {
                        label = 'Anzugs Hose',
                        drawable = 24,
                        texture = 4,
                    },
                    {
                        label = 'Anzugs Hose Breit',
                        drawable = 25,
                        texture = 4,
                    },
                    {
                        label = 'Sport Hose',
                        drawable = 32,
                        texture = 0,
                    },
                    {
                        label = 'Bademantel',
                        drawable = 56,
                        texture = 3,
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Schwarzer Rollkragen',
                        drawable = 111,
                        texture = 3
                    },
                    {
                        label = 'Roter Bravo Pulli',
                        drawable = 134,
                        texture = 1
                    },
                    {
                        label = 'Weisses T-Shirt',
                        drawable = 273,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Kapuzenpullover',
                        drawable = 134,
                        texture = 0
                    },
                    {
                        label = 'Unterhemd',
                        drawable = 237,
                        texture = 0
                    },
                    {
                        label = 'Roter Mantel',
                        drawable = 108,
                        texture = 0
                    },
                    {
                        label = 'Roter Mantel 2',
                        drawable = 107,
                        texture = 2
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    }
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    }
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    }
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['orga'] = {
        name = 'orga',
        label = 'ORGANISAZIJA',
        spawn = vector3(-1144.867, 4909.942, 220.9688),
        clothing = vector3(-1148.73, 4906.945, 220.9688),
        garage = {
            pos = vector3(-1139.559, 4916.974, 219.9497),
            spawns = {
                vector4(-1136.451, 4925.416, 220.0286, 258.2865)
            }
        },
        color = {
            rgb = {
                r = 206,
                g = 150,
                b = 65
            },
            bg = 'rgba(206, 150, 65, 0.15)',
            border = 'rgba(206, 150, 65, 0.25)',
            border_hover = 'rgba(206, 150, 65, 0.5)',
            img_border = '#CE9642',
            label_bg = 'rgba(206, 150, 65, 0.25)',
            label_color = '#CE9642',
            hover = 'linear-gradient(90deg, rgba(206, 150, 65, 0.25) 0%, rgba(206, 150, 65, 0.5) 50.23%, rgba(206, 150, 65, 0.25) 100%)',
            circle_bg = 'rgba(206, 150, 65, 0.25)',
            circle_border = 'rgba(206, 150, 65, 0.5)',
            circle_fill = '#CE9642',
            faction_bg = '#5e4621',
            blip = 0
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 171,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 28,
                        textureId = 14,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 54,
                        textureId = 2,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 139,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 28,
                        textureId = 14,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 57,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 111,
                        textureId = 3,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 9,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 115,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Tuch Maske',
                        drawable = 54,
                        texture = 2
                    },
                    {
                        label = 'Sturmhaube',
                        drawable = 57,
                        texture = 0
                    },
                    {
                        label = 'Voll Maske',
                        drawable = 115,
                        texture = 0
                    },

                },
                ['pants'] = {
                    {
                        label = 'Beige Anzugshose',
                        drawable = 28,
                        texture = 14
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Schwarzer Rollkragen',
                        drawable = 111,
                        texture = 3
                    },
                    {
                        label = 'Roter Bravo Pulli',
                        drawable = 134,
                        texture = 1
                    },
                    {
                        label = 'Weisses T-Shirt',
                        drawable = 273,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Kapuzenpullover',
                        drawable = 134,
                        texture = 0
                    },
                    {
                        label = 'Unterhemd',
                        drawable = 237,
                        texture = 0
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['lostmc'] = {
        name = 'lostmc',
        label = 'LOST MC',
        spawn = vector3(2004.091, 3050.46, 47.21401),
        clothing = vector3(1994.197, 3052.562, 47.21449),
        garage = {
            pos = vector3(2010.271, 3050.979, 47.21355),
            spawns = {
                vector4(1985.005, 3072.405, 46.97481, 61.38351)
            }
        },
        color = {
            rgb = {
                r = 150,
                g = 90,
                b = 0
            },
            bg = 'rgba(150, 90, 0, 0.15)',
            border = 'rgba(150, 90, 0, 0.25)',
            border_hover = 'rgba(150, 90, 0, 0.5)',
            img_border = '#965B00',
            label_bg = 'rgba(150, 90, 0, 0.25)',
            label_color = '#965B00',
            hover = 'linear-gradient(90deg, rgba(150, 90, 0, 0.25) 0%, rgba(150, 90, 0, 0.5) 50.23%, rgba(150, 90, 0, 0.25) 100%)',
            circle_bg = 'rgba(150, 90, 0, 0.25)',
            circle_border = 'rgba(150, 90, 0, 0.5)',
            circle_fill = '#965B00',
            faction_bg = '#472c03',
            blip = 10
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 162,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 75,
                        textureId = 0,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 29,
                        textureId = 3,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 162,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 97,
                        textureId = 5,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 29,
                        textureId = 3,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 162,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 88,
                        textureId = 5,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 29,
                        textureId = 3,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Skull Maske',
                        drawable = 29,
                        texture = 3
                    },
                    {
                        label = 'Sturmhaube',
                        drawable = 57,
                        texture = 0
                    },
                },
                ['pants'] = {
                    {
                        label = 'Jeans',
                        drawable = 75,
                        texture = 0
                    },
                    {
                        label = 'Shorts',
                        drawable = 88,
                        texture = 5
                    },
                    {
                        label = 'Arbeits Hose',
                        drawable = 97,
                        texture = 5
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Kutte',
                        drawable = 162,
                        texture = 0
                    },
                    {
                        label = 'Schwarzer Pullover',
                        drawable = 182,
                        texture = 0
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['atzen'] = {
        name = 'atzen',
        label = 'AZTECAS',
        spawn = vector3(1408.565, 3619.475, 34.89431),
        clothing = vector3(1411.726, 3609.83, 35.02904),
        garage = {
            pos = vector3(1411.124, 3623.716, 34.89294),
            spawns = {
                vector4(1421.175, 3615.007, 34.94202, 207.2323)
            }
        },
        color = {
            rgb = {
                r = 0,
                g = 255,
                b = 255
            },
            bg = 'rgba(0, 255, 255, 0.15)',
            border = 'rgba(0, 255, 255, 0.25)',
            border_hover = 'rgba(0, 255, 255, 0.5)',
            img_border = '#00FFFF',
            label_bg = 'rgba(0, 255, 255, 0.25)',
            label_color = '#00FFFF',
            hover = 'linear-gradient(90deg, rgba(0, 255, 255, 0.25) 0%, rgba(0, 255, 255, 0.5) 50.23%, rgba(0, 255, 255, 0.25) 100%)',
            circle_bg = 'rgba(0, 255, 255, 0.25)',
            circle_border = 'rgba(0, 255, 255, 0.5)',
            circle_fill = '#00FFFF',
            faction_bg = '#004747',
            blip = 57
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 332,
                        textureId = 19,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 16,
                        textureId = 8,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 257,
                        textureId = 18,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 54,
                        textureId = 5,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 308,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 139,
                        textureId = 0,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 0,
                        textureId = 0,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Voll Maske',
                        drawable = 115,
                        texture = 7
                    },
                },
                ['pants'] = {
                    {
                        label = 'Blaue Enge Jogger',
                        drawable = 128,
                        texture = 7
                    },
                    {
                        label = 'Gemusterte Jogginghose',
                        drawable = 139,
                        texture = 0
                    },
                    {
                        label = 'Blaue Jogginghose',
                        drawable = 64,
                        texture = 5
                    },
                    {
                        label = 'Karro Anzugshose',
                        drawable = 60,
                        texture = 5
                    },
                    {
                        label = 'Schneemann',
                        drawable = 58,
                        texture = 11
                    },
                    {
                        label = 'Pinguin',
                        drawable = 58,
                        texture = 8
                    },
                    {
                        label = 'Blaue Shorts',
                        drawable = 16,
                        texture = 8
                    },
                    {
                        label = 'Schwarz-Blaue Shorts',
                        drawable = 54,
                        texture = 5
                    },
                    {
                        label = 'Blaue Jeans',
                        drawable = 104,
                        texture = 0
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Weisse Jogger',
                        drawable = 332,
                        texture = 19
                    },
                    {
                        label = 'Weisser Kapuzenpullover',
                        drawable = 305,
                        texture = 0
                    },
                    {
                        label = 'Bigness Pullover',
                        drawable = 308,
                        texture = 0
                    },
                    {
                        label = 'Weisse Jacke',
                        drawable = 141,
                        texture = 5
                    },
                    {
                        label = 'Blaue Jacke',
                        drawable = 257,
                        texture = 18
                    },
                    {
                        label = 'Weisses T-Shirt',
                        drawable = 273,
                        texture = 0
                    }
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Yacht Schuhe',
                        drawable = 92,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                    {
                        label = 'Blaue Crocs',
                        drawable = 112,
                        texture = 15
                    },
                    {
                        label = 'Schwarze MSCHF',
                        drawable = 118,
                        texture = 0
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                    {
                        label = 'Blauer Hut',
                        drawable = 64,
                        texture = 5
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['rednecks'] = {
        name = 'rednecks',
        label = 'GRAPESEED REDNECKS',
        spawn = vector3(2435.148, 5012.124, 46.85517),
        clothing = vector3(2439.557, 5007.336, 46.66314),
        garage = {
            pos = vector3(2451.168, 5015.937, 45.8772),
            spawns = {
                vector4(2465.286, 5019.213, 45.58982, 216.5142)
            }
        },
        color = {
            rgb = {
                r = 0,
                g = 153,
                b = 0
            },
            bg = 'rgba(0, 153, 0, 0.15)',
            border = 'rgba(0, 153, 0, 0.25)',
            border_hover = 'rgba(0, 153, 0, 0.5)',
            img_border = '#009900',
            label_bg = 'rgba(0, 153, 0, 0.25)',
            label_color = '#009900',
            hover = 'linear-gradient(90deg, rgba(0, 153, 0, 0.25) 0%, rgba(0, 153, 0, 0.5) 50.23%, rgba(0, 153, 0, 0.25) 100%)',
            circle_bg = 'rgba(0, 153, 0, 0.25)',
            circle_border = 'rgba(0, 153, 0, 0.5)',
            circle_fill = '#009900',
            faction_bg = '#003b00',
            blip = 52
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 171,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 5,
                        textureId = 13,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 54,
                        textureId = 5,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 15,
                        textureId = 34,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 171,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 28,
                        textureId = 4,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 54,
                        textureId = 5,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 15,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 0,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 171,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 88,
                        textureId = 15,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 34,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 54,
                        textureId = 5,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 15,
                        textureId = 2,

                    },
                },
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Tuchmaske',
                        drawable = 54,
                        texture = 5
                    },
                    {
                        label = 'Bandana Maske',
                        drawable = 111,
                        texture = 19
                    },
                },
                ['pants'] = {
                    {
                        label = 'Shorts',
                        drawable = 88,
                        texture = 15
                    },                    {
                        label = 'Anzugshose',
                        drawable = 28,
                        texture = 4
                    },                    {
                        label = 'Jogginghose',
                        drawable = 5,
                        texture = 13
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Schwarzer Pullover',
                        drawable = 171,
                        texture = 0
                    },
                    {
                        label = 'Weste',
                        drawable = 173,
                        texture = 0
                    },
                    {
                        label = 'Jacke',
                        drawable = 172,
                        texture = 0
                    },
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0
                    },
                    {
                        label = 'Keine Schuhe',
                        drawable = 34,
                        texture = 0
                    },
                    {
                        label = 'Sandalen',
                        drawable = 6,
                        texture = 0
                    },
                    {
                        label = 'Schwarze Crocs',
                        drawable = 112,
                        texture = 0
                    },
                    {
                        label = 'Weisse Crocs',
                        drawable = 112,
                        texture = 3
                    },
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                },
            }
        }
    },
    ['lcn'] = {
        name = 'lcn',
        label = 'LA COSA NOSTRA',
        spawn = vector3(-1535.432, 97.42217, 56.76787),
        clothing = vector3(-1536.801, 107.4524, 56.77979),
        garage = {
            pos = vector3(-1532.106, 78.85909, 56.7622),
            spawns = {
                vector4(-1527.609, 85.40218, 56.605, 265.6406)
            }
        },
        color = {
            rgb = {
                r = 0,
                g = 0,
                b = 0
            },
            bg = 'rgba(30, 30, 30, 0.15)',
            border = 'rgba(30, 30, 30, 0.25)',
            border_hover = 'rgba(30, 30, 30, 0.5)',
            img_border = '#1E1E1E',
            label_bg = 'rgba(30, 30, 30, 0.25)',
            label_color = '#1E1E1E',
            hover = 'linear-gradient(90deg, rgba(30, 30, 30, 0.25) 0%, rgba(30, 30, 30, 0.5) 50.23%, rgba(30, 30, 30, 0.25) 100%)',
            circle_bg = 'rgba(30, 30, 30, 0.25)',
            circle_border = 'rgba(30, 30, 30, 0.5)',
            circle_fill = '#1E1E1E',
            faction_bg = '#1E1E1E',
            blip = 0
        },
        clothes = {
            outfits = {
                [1] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 2,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 134,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 10,
                        textureId = 0,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 7,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 111,
                        textureId = 17,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [2] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 2,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 131,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 24,
                        textureId = 0,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 7,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 111,
                        textureId = 18,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                },
                [3] = {
                    { -- T Shirt
                        componentId = 8,
                        drawableId = 15,
                        textureId = 2,

                    },
                    { -- Torso
                        componentId = 11,
                        drawableId = 154,
                        textureId = 0,

                    },
                    { -- Hose
                        componentId = 4,
                        drawableId = 24,
                        textureId = 0,

                    },
                    { -- Schuhe
                        componentId = 6,
                        drawableId = 7,
                        textureId = 0,

                    },
                    { -- Mask
                        componentId = 1,
                        drawableId = 111,
                        textureId = 17,

                    },
                    { -- Weste
                        componentId = 9,
                        drawableId = 16,
                        textureId = 2,

                    },
                }
            },
            categories = {
                ['mask'] = {
                    {
                        label = 'Beige Maske',
                        drawable = 111,
                        texture = 18,
                    },
                    {
                        label = 'Schwarze Maske',
                        drawable = 111,
                        texture = 17,
                    }
                },
                ['pants'] = {
                    {
                        label = 'Schwarze Anzugshose',
                        drawable = 24,
                        texture = 0,
                    },
                    {
                        label = 'Breite Schwarze Anzugshose',
                        drawable = 10,
                        texture = 0,
                    },
                },
                ['shirt'] = {
                    {
                        label = 'Liberty Shirt',
                        drawable = 131,
                        texture = 0,
                    },
                    {
                        label = 'Liberty Pullover',
                        drawable = 134,
                        texture = 0,
                    },
                    {
                        label = 'Leder Jacke',
                        drawable = 154,
                        texture = 0,
                    }
                },
                ['shoes'] = {
                    {
                        label = 'Weisse Sneaker',
                        drawable = 7,
                        texture = 0,
                    }
                },
                ['hat'] = {
                    {
                        label = 'Kopfhörer',
                        drawable = 15,
                        texture = 6
                    },
                    {
                        label = 'Hut',
                        drawable = 29,
                        texture = 2
                    },

                    {
                        label = 'Durag',
                        drawable = 83,
                        texture = 0
                    },
                },
                ['glasses'] = {
                    {
                        label = 'Weiße Sonnenbrille',
                        drawable = 16,
                        texture = 5
                    },
                    {
                        label = 'Fliegerbrille',
                        drawable = 24,
                        texture = 0
                    },
                    {
                        label = 'Schwarz/Graue Ski Brille',
                        drawable = 25,
                        texture = 4
                    },
                    {
                        label = 'Weiße Brille',
                        drawable = 29,
                        texture = 2
                    },
                },
                ['earrings'] = {
                    {
                        label = 'Würfel',
                        drawable = 39,
                        texture = 5
                    },
                },
                ['chain'] = {
                    {
                        label = 'Silberkette',
                        drawable = 17,
                        texture = 0
                    },
                    {
                        label = 'Goldkette',
                        drawable = 17,
                        texture = 1
                    },
                    {
                        label = 'Kopfhörer',
                        drawable = 114,
                        texture = 0
                    },
                    {
                        label = 'Felgenkette',
                        drawable = 120,
                        texture = 0
                    },
                }
            }
        },
    }
}

-- SetPedComponentVariation(
-- 	ATH.PlayerData.ped, 
-- 	componentId, 
-- 	drawableId, 
-- 	textureId, 
-- 	paletteId
-- )

--[[ component
	0: Face
	1: Mask
	2: Hair
	3: Torso
	4: Leg
	5: Parachute / bag
	6: Shoes
	7: Accessory
	8: Undershirt
	9: Kevlar
	10: Badge
	11: Torso 2
]]