/datum/reagent/consumable/laughsyrup
	name = "Laughin' Syrup"
	description = "The product of juicing Laughin' Peas. Fizzy, and seems to change flavour based on what it's used with!"
	nutriment_factor = 5 * REAGENTS_METABOLISM
	color = "#803280"
	taste_mult = 2
	taste_description = "fizzy sweetness"

/datum/reagent/consumable/pyre_elementum
	name = "Pyre Elementum"
	description = "A high-energy thermochemical slurry, extracted from fireblossoms. Capable of acting as a fairly potent stimulant."
	color = "#c67117"
	taste_description = "burning heat"
	taste_mult = 8.0
	nutriment_factor = -1 * REAGENTS_METABOLISM
	var/ingested = FALSE
	var/injected = FALSE
	metabolization_rate = 0.4

/datum/reagent/consumable/pyre_elementum/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/pyre)

/datum/reagent/consumable/pyre_elementum/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/pyre)
	..()

/datum/reagent/consumable/pyre_elementum/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == INGEST)
		ingested = TRUE
		return
	if(method == INJECT)
		injected = TRUE
		return
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "pyre_elementum", /datum/mood_event/irritate, name)		// Applied if not eaten
	if(method == TOUCH || method == VAPOR)
		M.adjust_fire_stacks(reac_volume / 5)
		return
	..()

/datum/reagent/consumable/pyre_elementum/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0)//can now kill you
	if(!ingested)							// Burns all the way down
		M.adjustFireLoss(0.3*REM, 0)
	if(!injected)							// This was a bad idea
		M.adjustFireLoss(0.5*REM, 0)
	M.AdjustStun(-20)
	M.AdjustKnockdown(-20)
	M.AdjustUnconscious(-20)
	M.AdjustParalyzed(-20)
	M.AdjustImmobilized(-20)
	M.adjustStaminaLoss(-2, 0)
	M.Jitter(2)
	for(var/datum/reagent/R as anything in M.reagents.reagent_list)
		if(R == src)
			continue
		if(!(R.type in list(/datum/reagent/drug/methamphetamine, /datum/reagent/consumable/pyre_elementum)))
			continue
		M.reagents.remove_reagent(R.type,15)
		to_chat(M, "<span class='userwarning'>You feel like something's burning inside you...</span>")//this is totally me when I drink two chemicals that explode when combined
		M.adjust_bodytemperature(40 * TEMPERATURE_DAMAGE_COEFFICIENT, 0)
		M.adjust_fire_stacks(1)
		M.adjustFireLoss(2*REM, 0)
		M.IgniteMob()
	..()

/datum/reagent/consumable/pyre_elementum/on_mob_end_metabolize(mob/living/M)
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "pyre_elementum")
	..()

//meth and pyre create an even more powerful stim(about 1.7 meths), that literally ignites you from the inside. Addiction causes an unquenchable flaming curse, eventually causes the user to burn clean through and become a skeleton.
/datum/reagent/consumable/fumerol
	name = "Fumerol"
	description = "The result of double-stimming with a stabilized methamphetamines and pyre elementum reaction. Extreme side effects may result if combined with additional methamphetamine or pyre while within the body."
	color = "#f74610"
	taste_description = "UNQUENCHABLE FLAMES"
	taste_mult = 10.0
	nutriment_factor = -5 * REAGENTS_METABOLISM//burns through anything in your stomach. Why are you drinking this?
	var/ingested = FALSE
	var/injected = FALSE
	addiction_threshold = 20
	metabolization_rate = 0.4//much slower then meth, which is arguably a bad thing considering the CONSTANT FLAMES OF VENGANCE LICKING YOUR BODY

/datum/reagent/consumable/fumerol/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/fumerol)

/datum/reagent/consumable/fumerol/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/fumerol)
	..()

/datum/reagent/consumable/fumerol/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "fumerol1", /datum/mood_event/fumerolgood, name)//FEEL THE HEAT
	M.IgniteMob()
	if(M.fire_stacks >= 10)
		M.adjust_fire_stacks(reac_volume / 5)
	if(method == INGEST)
		ingested = TRUE
		return
	if(method == INJECT)
		injected = TRUE
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "fumerol2", /datum/mood_event/fumerolbad, name)// Yes, inject the liquid fire directly into your veins
		return
	..()

/datum/reagent/consumable/fumerol/on_mob_life(mob/living/carbon/M)
	var/FLAME_message = pick("You're POSITIVELY FUMING.", "You're BLAZING LIKE A FOREST FIRE!", "You feel the BURNING POWER to go EVEN FURTHER BEYOND!", "You BURN AND BURN, BUT THE FIRE KEEPS GETTING HIGHER.")
	if(prob(10))
		to_chat(M, "<span class='notice'>[FLAME_message]</span>")
	M.adjust_bodytemperature(40 * TEMPERATURE_DAMAGE_COEFFICIENT, 0)
	if(!injected)							// This was a bad idea
		M.adjustFireLoss(0.5*REM, 0)
	if(M.on_fire == 0)
		M.adjust_fire_stacks(2)
		M.IgniteMob()
	M.AdjustStun(-70)
	M.AdjustKnockdown(-70)
	M.AdjustUnconscious(-70)
	M.AdjustParalyzed(-70)
	M.AdjustImmobilized(-70)
	M.adjustStaminaLoss(-15, 0)
	if(M.fire_stacks >= 5)
		M.adjust_fire_stacks(0.5)//continuously increases fire stacks while in your system, up to a point
	M.Jitter(4)
	if(prob(5))
		M.emote(pick("twitch", "spasm"))
	. = 1
	for(var/datum/reagent/R as anything in M.reagents.reagent_list)
		if(R == src)
			continue
		if(!(R.type in list(/datum/reagent/drug/methamphetamine, /datum/reagent/consumable/pyre_elementum)))
			continue
		M.reagents.remove_reagent(R.type,25)
		to_chat(M, "<span class='userwarning'>You feel a violent reaction within your veins!</span>")//AAAAAAAAAAAAAAAA
		M.adjust_bodytemperature(100 * TEMPERATURE_DAMAGE_COEFFICIENT, 0)
		M.adjust_fire_stacks(4)
		M.adjustFireLoss(4*REM, 0)
	..()

/datum/reagent/consumable/fumerol/on_mob_end_metabolize(mob/living/M)
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "fumerol1")
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "fumerol2")
	..()

/datum/reagent/consumable/fumerol/addiction_act_stage1(mob/living/M)
	if(prob(30))
		to_chat(M, "<span class='danger'>The flames won't go out...</span>")
	M.color = "#c2c2c2"
	M.adjustFireLoss(-1.5)
	if(M.on_fire == 0)
		M.adjust_fire_stacks(1)
		M.IgniteMob()
	..()
	. = 1

/datum/reagent/consumable/fumerol/addiction_act_stage2(mob/living/M)//dangerous and lethal phase of Fumerol Conversion.
	if(prob(30))
		to_chat(M, "<span class='danger'>The flames keep creeping higher...</span>")
		M.adjust_fire_stacks(5)
	M.adjustFireLoss(-2)
	M.color = "#c2c2c2"
	if(M.on_fire == 0)
		M.adjust_fire_stacks(2)
		M.IgniteMob()
	..()

/datum/reagent/consumable/fumerol/addiction_act_stage3(mob/living/M)//as you enter the final stages of transforming into a skeleton, there's little left to actually be burnt
	if(prob(30))
		to_chat(M, "<span class='danger'>You can feel your pain fading away...</span>")
		M.adjustFireLoss(-7)//sweet relief?
	M.color = "#908c8c"
	if(M.on_fire == 0)
		M.adjust_fire_stacks(1)
		M.IgniteMob()
	..()
	. = 1

/datum/reagent/consumable/fumerol/addiction_act_stage4(mob/living/carbon/human/M)
	CHECK_DNA_AND_SPECIES(M)
	if(!istype(M.dna.species, /datum/species/skeleton))
		to_chat(M, "<span class='userdanger'>The last of your flesh softly crumbles away... Revealing the skeleton beneath.</span>")
		M.ExtinguishMob()
		M.color = "#FFFFFF"
		M.heal_overall_damage(100)
		M.set_species(/datum/species/skeleton)
		new /obj/effect/decal/cleanable/ash/large(M)
	else
		M.color = null
	..()
	. = 1

/datum/reagent/consumable/fervor
	name = "Fervor Ignium"
	description = "Healing chem made from mushrooms."
	color = "#b6a076"
	taste_description = "mushrooms"
	nutriment_factor = -1 * REAGENTS_METABOLISM

/datum/reagent/consumable/fervor/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.adjustBruteLoss(-2*REM, 0)
		M.adjustFireLoss(-2*REM, 0)
	M.adjustStaminaLoss(-5*REM, 0)
	..()
