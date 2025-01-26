//function iniciarSushi()
//{
if (chamada_uma_vez && global.minigameSushi) {
	with(Right_1){visible = false};
	with(Right_2){visible = false};	
	with(Right_3){visible = false};
	
	 with (Vazio_1) {image_xscale = 0.5; image_yscale = 0.5;};
	 with (Vazio_2) {image_xscale = 0.5; image_yscale = 0.5;};
	 with (Vazio_3) {image_xscale = 0.5; image_yscale = 0.5;};
	 
	 with (Level_1) {image_xscale = 0.45; image_yscale = 0.45; visible = false};
	 with (Level_2) {image_xscale = 0.45; image_yscale = 0.45; visible = false};
	 with (Level_3) {image_xscale = 0.45; image_yscale = 0.45; visible = false};
		
	sushi_one = irandom(2);
	sushi_two = irandom(2);
	sushi_three = irandom(2);
	
	setarSprites();
	
    chamada_uma_vez = false;
}
if(global.minigameSushi)
{
	timerButton +=1;
}

if(timerButton >= 200)
{
	if(!endGame)
	{
	endGame = true;
	audio_play_sound(WRONG, 1, false);
	}
	sairMinigameSushi();
}

function setarSprites()
{

	switch(sushi_one)
	{
		case 0: 
		  with (Vazio_1) {sprite_index =  Sushi_1___Peijofu;};
		  with (Level_1) {sprite_index =  Sushi_1___Peijofu;};
		break;
		
		case 1:   
		with (Vazio_1) { sprite_index =  Sushi_2___Cenogiri_;};
		  with (Level_1) {sprite_index =  Sushi_2___Cenogiri_;};
		break;
		
		case 2: 
		  with (Vazio_1) {sprite_index =  Sushi_3___Lulamaki_;};
		  with (Level_1) {sprite_index =  Sushi_3___Lulamaki_;};
		break;
	}
	
	switch(sushi_two)
	{
			case 0: 
		  with (Vazio_2) { sprite_index =  Sushi_1___Peijofu;};
		  with (Level_2) {sprite_index =  Sushi_1___Peijofu;};
		break;
		
		case 1:  
		with (Vazio_2) {sprite_index =  Sushi_2___Cenogiri_;};
		  with (Level_2) {sprite_index =  Sushi_2___Cenogiri_;};
		break;
		
		case 2: 
		  with (Vazio_2) {sprite_index =  Sushi_3___Lulamaki_;};
		  with (Level_2) {sprite_index =  Sushi_3___Lulamaki_;};
		break;
	}
	
	switch(sushi_three)
	{
			case 0: 
		  with (Vazio_3) {sprite_index =  Sushi_1___Peijofu;};
		  with (Level_3) {sprite_index =  Sushi_1___Peijofu;};
		break;
		
		case 1:  
		with (Vazio_3) {sprite_index =  Sushi_2___Cenogiri_; };
		  with (Level_3) {sprite_index =  Sushi_2___Cenogiri_;};
		break;
		
		case 2: 
		  with (Vazio_3) {sprite_index =  Sushi_3___Lulamaki_;};
		  with (Level_3) {sprite_index =  Sushi_3___Lulamaki_;};
		break;
	}
}


if(selected != 9){
	if(selected_one == 9)
	{	
		selected_one = selected;
	}
	else if(selected_two == 9)
	{	
		selected_two = selected;
	}
	else if(selected_three == 9)
	{
		selected_three = selected;
	}
	
	selected = 9;
}
	
if(selected_one != 9)
{	
	with(Right_1){visible = true};
	if(selected_one == sushi_one)
	{
		with(Right_1){sprite_index = Correct_sprite;}
		
		with (Level_1) {
			visible = true
		}
	}
	else
	{
		with(Right_1){sprite_index = Wrong_Sprite;}
		if(!endGame) audio_play_sound(WRONG, 1, false);
		sairMinigameSushi();
	}
}

if(selected_two != 9)
{	
	with(Right_2){visible = true};
	if(selected_two == sushi_two)
	{
		with(Right_2){sprite_index = Correct_sprite;}
			with (Level_2) {
			visible = true
		}
	}
	else
	{
		with(Right_2){sprite_index = Wrong_Sprite;}
		if(!endGame) audio_play_sound(WRONG, 1, false);
		sairMinigameSushi();
	}
}

if(selected_three != 9)
{	
	with(Right_3){visible = true};
	if(selected_three == sushi_three)
	{
		with(Right_3){sprite_index = Correct_sprite;}
		with (Level_3) {
			visible = true
		}

		minigameCompletado();
	}
	else
	{
		with(Right_3){sprite_index = Wrong_Sprite;}
		if(!endGame) audio_play_sound(WRONG, 1, false);
		sairMinigameSushi();
	}
}

function minigameCompletado()
{
	//CODIGO DE GANHAR PONTOS
	if(!endGame) audio_play_sound(CORRECT, 1, false);
	sairMinigameSushi();
}

function sairMinigameSushi()
{
	endGame = true;
	endTimer +=1;
	
	if(endTimer > 50)
	{
	timerButton = 0;
	endTimer = 0;
	selected = 9;
	selected_one = 9;
	selected_two = 9;
	selected_three = 9;
	
	with(Right_1){visible = false};
	with(Right_2){visible = false};	
	with(Right_3){visible = false};
	
	layer_set_visible("MinigameSUSHI", false);
	view_set_visible(0, true);
	view_set_visible(2, false);
	endGame = false;
	
	chamada_uma_vez = true;
	
	global.minigameSushi = false;
	}
}