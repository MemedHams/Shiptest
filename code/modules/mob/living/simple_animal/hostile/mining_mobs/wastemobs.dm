///the cytomob unique content needs serious rework to both trigger as part of ai behavior and work within our ability system.
//So these are mostly basemobs for now.

/mob/living/simple_animal/hostile/asteroid/vatbeast
	name = "vatbeast"
	desc = "A strange molluscoidal creature carrying a busted growing vat.\nYou wonder if this burden is a voluntary undertaking in order to achieve comfort and protection, or simply because the creature is fused to its metal shell?"
	icon = 'icons/mob/vatgrowing.dmi'
	icon_state = "vat_beast"
	icon_living = "vat_beast"
	icon_dead = "vat_beast_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mob_size = MOB_SIZE_LARGE
	gender = NEUTER
	environment_smash = ENVIRONMENT_SMASH_MINERALS
	speak_emote = list("roars")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	health = 210
	maxHealth = 210
	melee_damage_lower = 30
	melee_damage_upper = 30
	obj_damage = 40
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	attack_sound = 'sound/weapons/punch3.ogg'
	attack_verb_continuous = "slaps"
	attack_verb_simple = "slap"
	vision_range = 9
	weather_immunities = list("acid")
	armor = list("melee" = 45, "bullet" = 25, "laser" = 10, "energy" = 0, "bomb" = 10, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 75)
	food_type = list(/obj/item/reagent_containers/food/snacks/fries, /obj/item/reagent_containers/food/snacks/cheesyfries, /obj/item/reagent_containers/food/snacks/cornchips, /obj/item/reagent_containers/food/snacks/carrotfries)
	tame_chance = 0
	bonus_tame_chance = 10
	charger = TRUE
	charge_frequency = 6 SECONDS
	move_to_delay = 8
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mollusc = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/ore/salvage/scrapmetal = 10)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/mollusc = 1, /obj/item/stack/ore/salvage/scrapmetal = 5)

/mob/living/simple_animal/hostile/asteroid/vatbeast/tamed(mob/living/tamer)
	charger = FALSE
	buckle_lying = 0
	can_buckle = TRUE
	tamer.visible_message("<span class='notice'>You notice that the Vatbeast appears to have become more docile. They might let you climb aboard.</span>")
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 8), TEXT_SOUTH = list(0, 8), TEXT_EAST = list(-2, 8), TEXT_WEST = list(2, 8)))
	D.set_vehicle_dir_layer(SOUTH, ABOVE_MOB_LAYER)
	D.set_vehicle_dir_layer(NORTH, OBJ_LAYER)
	D.set_vehicle_dir_layer(EAST, OBJ_LAYER)
	D.set_vehicle_dir_layer(WEST, OBJ_LAYER)
	D.drive_verb = "ride"
	faction = list("neutral")

//oozes
/mob/living/simple_animal/hostile/asteroid/ooze
	name = "Ooze"
	icon = 'icons/mob/vatgrowing.dmi'
	icon_state = "gelatinous"
	icon_living = "gelatinous"
	icon_dead = "gelatinous_dead"
	mob_biotypes = MOB_ORGANIC
	pass_flags = PASSTABLE | PASSGRILLE
	gender = NEUTER
	emote_see = list("jiggles", "bounces in place")
	speak_emote = list("blorbles")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	armor = list("melee" = 0, "bullet" = 25, "laser" = 25, "energy" = 45, "bomb" = 10, "bio" = 10, "rad" = 10, "fire" = 30, "acid" = 85)
	minbodytemp = 250
	maxbodytemp = INFINITY
	weather_immunities = list("acid")
	faction = list("slime")
	melee_damage_lower = 10
	melee_damage_upper = 10
	health = 150
	maxHealth = 150
	ventcrawler = VENTCRAWLER_ALWAYS
	attack_verb_continuous = "slimes"
	attack_verb_simple = "slime"
	attack_sound = 'sound/effects/blobattack.ogg'
	environment_smash = ENVIRONMENT_SMASH_MINERALS
	mob_size = MOB_SIZE_LARGE
	initial_language_holder = /datum/language_holder/slime
	footstep_type = FOOTSTEP_MOB_SLIME
	///Oozes have their own nutrition. Changes based on them eating
	//var/ooze_nutrition = 50
	//var/ooze_nutrition_loss = -0.15
	//var/ooze_metabolism_modifier = 2
	///Bitfield of edible food types
	//var/edible_food_types = MEAT

/mob/living/simple_animal/hostile/ooze/Initialize(mapload)
	. = ..()
	create_reagents(300)

/mob/living/simple_animal/hostile/asteroid/ooze/gelatinous
	name = "Gelatinous Cube"
	desc = "A cubic ooze native to Sholus VII.\nSince the advent of space travel this species has established itself in the waste treatment facilities of several space colonies.\nIt is often considered to be the third most infamous invasive species due to its highly aggressive and predatory nature."
	speed = 1
	melee_damage_lower = 20
	melee_damage_upper = 20
	armour_penetration = 15
	obj_damage = 40
	deathmessage = "collapses into a pile of goo!"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/cube = 5)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/cube = 1)

//grape slime is basically nonfunctional without above changes, so I've left it out for now

