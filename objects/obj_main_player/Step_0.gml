/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if (!is_main_player) exit;
var has_moved = false;

function set_animation (state) {
	new_animation = variable_struct_get(animations, state);
	animation_frames = new_animation.frames;
}

animations = {
	idling: {frames: [0]},
	left:	{frames: [0,1,2]},
	right:	{frames: [0,1,2]},
	up:		{frames: [0,1,2]},
	down:	{frames: [0,1,2]},
}
set_animation("idling");

if (keyboard_check(vk_right)) {
	hsp = move_speed;
	has_moved = true;
} else if (keyboard_check(vk_left)) {
	hsp = -move_speed;
	has_moved = true;
} else {
	hsp = 0;	
}

if (keyboard_check(vk_up)) {
	vsp = -move_speed;
	has_moved = true;
} else if (keyboard_check(vk_down)) {
	vsp = +move_speed;
	has_moved = true;
} else {
	vsp = 0;
}

x += hsp;
y += vsp;

/*if (place_meeting(x, y, obj_enemy)) {
	game_restart();
}*/

if (is_main_player && has_moved ) {
	send_network_data(json_stringify({type: "move", x: x, y: y}));
} else {
	set_animation("idling");
}

has_moved = false;