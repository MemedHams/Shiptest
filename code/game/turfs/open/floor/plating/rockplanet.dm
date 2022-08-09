/turf/open/floor/plating/asteroid/rockplanet
	name = "oxide sand"
	desc = "The sway of wind and water rent hematite rock into reddish dust. Now it crunches softly underfoot."
	icon_state = "dry_soft"
	base_icon_state = "dry_soft"
	floor_variance = 100
	max_icon_states = 7
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	digResult = /obj/item/stack/ore/glass/rockplanet

/turf/open/floor/plating/asteroid/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/plating/asteroid/rockplanet/cracked
	name = "dried oxide sand"
	desc = "Sand grows brittle and tough under the withering glare of the midday sun."
	icon_state = "dry_cracked0"
	base_icon_state = "dry_cracked"
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet

/turf/open/floor/plating/asteroid/rockplanet/cracked/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit
	turf_type = /turf/open/floor/plating/asteroid/rockplanet/lit

/turf/open/floor/plating/asteroid/rockplanet/wet
	icon_state = "wet_soft0"
	base_icon_state = "wet_soft"

/turf/open/floor/plating/asteroid/rockplanet/wet/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked
	name = "muddy oxide sand"
	desc = "Red earth grows damp and sticky underfoot, loostening back into soil."
	icon_state = "wet_cracked0"
	base_icon_state = "wet_cracked"

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
