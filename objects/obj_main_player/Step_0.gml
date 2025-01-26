/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (!is_main_player) exit;
var has_moved = false;

show_debug_message(joystick_moved);

function animationsProgression(){
animationTimer +=1;
}
function animationResset(){
   image_index = 0;
}

//image_speed  = 0;

	if (animationTimer >= 5) {
		if (image_index == 0) {
		        image_index = 1;
		    } else if (image_index == 1) {
		        image_index = 2;
		    } else if (image_index == 2) {
		        image_index = 3;
		    } else {
		        image_index = 0;
	    }
		animationTimer = 0;
}

function set_animation (state) {
	new_animation = variable_struct_get(animations, state);
	animation_frames = new_animation.frames;
}

animations = {
	idling: {frames: [0]},
	walking:{frames: [0,1]},
	left:	{frames: [0,1,2]},
	right:	{frames: [0,1,2]},
	up:		{frames: [0,1,2]},
	down:	{frames: [0,1,2]},
}


if (keyboard_check(vk_right) || joystick_moved) {
	if(!joystick_moved)
	{
		hsp = move_speed;
	}
	image_xscale = 0.5;
	animationsProgression();
	
	has_moved = true;
} else if (keyboard_check(vk_left) || joystick_moved) {
	if(!joystick_moved)
	{
		hsp = -move_speed;
	}
	
	image_xscale = -0.5;
	has_moved = true;
	
	animationsProgression();
} else if (!joystick_moved){
	hsp = 0;
}

if (keyboard_check(vk_up) || joystick_moved) {
	if(!joystick_moved)
	{
		vsp = -move_speed;
	}
	
	has_moved = true;
	animationsProgression();
} else if (keyboard_check(vk_down) || joystick_moved) {
	if(!joystick_moved)
	{
		vsp = +move_speed;
	}
	
	has_moved = true;
	animationsProgression();
} else if (!joystick_moved) {
	vsp = 0;
	
}

x += hsp;
y += vsp;

if(hsp == 0 && vsp ==0)
{
	animationResset();
}

/*if (place_meeting(x, y, obj_enemy)) {
	game_restart();
}*/

if (is_main_player && has_moved ) {
	send_network_data(json_stringify({type: "move", x: x, y: y}));
} else {
	//set_animation("idling");
}

has_moved = false;

if(global.minigamePesca)
{
	//instance_deactivate_object(minigamePesca);
	layer_set_visible("MinigamePESCA", true);
	view_set_visible(1, true);
}

if(global.minigameSushi)
{
	//instance_deactivate_object(minigamePesca);
	layer_set_visible("MinigameSUSHI", true);
	view_set_visible(2, true);
}
