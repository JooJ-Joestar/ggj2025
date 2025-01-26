if (chamada_uma_vez && global.minigamePesca)
{
	goalLocation = random_range(minPosition ,maxPosition);
	QTE_GOAL_OBJ.x = goalLocation;
	
	if(pointerSpeed == 0)
	{
		pointerSpeed = normalSpeed;
	}
	
	var dificulty = irandom(3);
	switch(dificulty)
	{
		case 0: pointerSpeed = easySpeed;
			QTE_FISH.sprite_index = fish_easy_hud;
		break;
		case 1: pointerSpeed = normalSpeed;
			QTE_FISH.sprite_index = fish_normal_hud;
			break;
		case 2: pointerSpeed = hardSpeed;
			QTE_FISH.sprite_index = fish_hard_hud;
			break;
	}	
	chamada_uma_vez = false;
}

if (keyboard_check_pressed(vk_backspace) && global.minigamePesca) {
	chamada_uma_vez = true;
}

if (keyboard_check_pressed(vk_space) && global.minigamePesca) {
	resolverQTEPesca();
}

function resolverQTEPesca()
{
if(pointerLocation <= goalLocation + 32 && pointerLocation >= goalLocation - 32)
	{
		audio_play_sound(CORRECT, 1, false);
	}
	else
	{
		audio_play_sound(WRONG, 1, false);
	}
	pointerSpeed = 0;
	
	desativarMinigamePesca();
}

if( global.minigamePesca)
{
	pointerLocation += pointerSpeed;
}

if(pointerLocation >= maxPosition +25 || pointerLocation <= minPosition -30)
{
	pointerSpeed *= -1;
}
QTE_POINTER_OBJ.x = pointerLocation;

function desativarMinigamePesca()
{
	//instance_deactivate_object(minigamePesca);
	layer_set_visible("MinigamePESCA", false);
	view_set_visible(0, true);
	view_set_visible(1, false);
	chamada_uma_vez= true;
	global.minigamePesca = false;
}