Teams = {
	['lostmc'] = {
		name = 'lostmc',
		label = 'LOST MC',
		spawn = vector3(-1.5, 19.2501, 71.1215),
		color = {
			bg = 'rgba(98, 98, 98, 0.15)',
			border = 'rgba(98, 98, 98, 0.25)',
			border_hover = 'rgba(98, 98, 98, 0.5)',
			img_border = 'rgba(98, 98, 98, 0.75)',
			label_bg = 'rgba(98, 98, 98, 0.25)',
			label_color = '#121212',
			hover = 'linear-gradient(90deg, rgba(98, 98, 98, 0.25) 0%, rgba(98, 98, 98, 0.5) 50.23%, rgba(98, 98, 98, 0.25) 100%);',
			circle_bg = 'rgba(98, 98, 98, 0.25)',
			circle_border = 'rgba(98, 98, 98, 0.5)',
			circle_fill = '#121212'
		},
		clothes = {
			[1] = {
				{
					componentId = 4,
					drawableId = 5,
					textureId = 3,
					paletteId = 0,
				},
				{
					componentId = 3,
					drawableId = 15,
					textureId = 2,
					paletteId = 0,
				},
				{
					componentId = 6,
					drawableId = 34,
					textureId = 0,
					paletteId = 0,
				},
				{
					componentId = 11,
					drawableId = 297,
					textureId = 4,
					paletteId = 0,
				},
			}
		}
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