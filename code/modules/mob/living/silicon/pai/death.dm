/mob/living/silicon/pai/death(gibbed)
	if(card)
		card.removePersonality()
		if(gibbed)
			src.loc = get_turf(card)
			del(card)
		else
			close_up()
	if(mind)
		del(mind)
	..(gibbed)
	ghostize()
	del(src)