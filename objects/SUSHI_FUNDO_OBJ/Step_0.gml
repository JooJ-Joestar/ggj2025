//function iniciarSushi()
//{
if (chamada_uma_vez) {
	sushi_one = irandom(3);
	sushi_two = irandom(3);
	sushi_three = irandom(3);
	
	setarSprites();
	
    chamada_uma_vez = false;
	
}


function setarSprites()
{
	var id_vazio_1 = Vazio_1;
	var id_vazio_2 = Vazio_2;
	var id_vazio_3 = Vazio_3;

	switch(sushi_one)
	{
		case 0: 
		  with (id_vazio_1) {sprite_index =  _1;}
		break;
		
		case 1:   
		with (id_vazio_1) { sprite_index =  _2;};
		break;
		
		case 2: 
		  with (id_vazio_1) {sprite_index =  _3;}
		break;
	}
	
	switch(sushi_two)
	{
			case 0: 
		  with (id_vazio_2) { sprite_index =  _1;}; 
		break;
		
		case 1:   with (id_vazio_2) {sprite_index =  _2};
		break;
		
		case 2: 
		  with (id_vazio_2) {sprite_index =  _3;};
		break;
	}
	
	switch(sushi_three)
	{
			case 0: 
		  with (id_vazio_3) {sprite_index =  _1;}
		break;
		
		case 1:   with (id_vazio_3) {sprite_index =  _2; };
		break;
		
		case 2: 
		  with (id_vazio_3) {sprite_index =  _3;}
		break;
	}
}


	
if(selected_one != 9)
{	
	id_correto_1.visible = true;
	if(selected_one == sushi_one)
	{
		with(id_correto_1){sprite_index = Correct_sprite;}
	}
	else
	{
		with(id_correto_1){sprite_index = Wrong_Sprite;}
	}
}
else
{
	with(id_correto_1){
		id_correto_1.visible = false;
		}
}

if(selected_two != 9)
{	
	id_correto_2.visible = true;
	if(selected_two == sushi_two)
	{
		with(id_correto_2){sprite_index = Correct_sprite;}
	}
	else
	{
		with(id_correto_2){sprite_index = Wrong_Sprite;}
	}
}
else
{
	with(id_correto_2){
		id_correto_2.visible = false;
		}
}

if(selected_three != 9)
{	
	id_correto_3.visible = true;
	if(selected_three == sushi_three)
	{
		with(id_correto_3){sprite_index = Correct_sprite;}
	}
	else
	{
		with(id_correto_3){sprite_index = Wrong_Sprite;}
	}
}
else
{
	with(id_correto_3){
		id_correto_3.visible = false;
		}
}