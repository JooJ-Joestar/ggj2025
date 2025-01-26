pig = false;

/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
quantidade_one = 2;
quantidade_two = 2;
quantidade_three = 2;
match_timer = 0;
score = 0;

animationSpeed = 0;

shooting = false;

global.minigameSushi = false;
global.minigamePesca = false;
playerDirecao = 6;

image_speed = 0;
image_index = 0;

scale = 0.35;

image_xscale = scale;
image_yscale = scale;

animationTimer =0;

global.debug = true;

is_main_player = variable_instance_get(id, "is_main_player");
if(is_main_player) 
{
	global.main_player = id;
}
hsp = 0;
vsp = 0;
original_move_speed = 4;
move_speed = original_move_speed;
has_wood = false;
time_source_fucked = false;
fucked_timeout = 1;

joystick_moved = false;

placing_house = false;
placing_house_duration = 1;
time_source_house = false;

active_bomb = false;
bomb_fuse_delay = 1;
bomb_cooldown = 3;
time_source_bomb = false;

player_server_id = "";
player_list = [];

alarm[0] = game_get_speed(gamespeed_fps);

function send_network_data (json_data) {
	if (!is_main_player) exit;
	buffer_delete(player_buffer);
	player_buffer = buffer_create(200, buffer_grow, 200);
	//buffer_seek(player_buffer, buffer_seek_start, 0);
	buffer_write(player_buffer, buffer_string, json_data);
	network_send_raw(client, player_buffer, 200, 1);
}


function create_house () {
	var restore_speed = function restore_speed (new_speed) {
		move_speed = new_speed;
		placing_house = false;
	}

	has_wood = false;
	move_speed = 0;
	time_source_house = time_source_create(time_source_game, placing_house_duration, time_source_units_seconds, restore_speed, [original_move_speed]);
	time_source_start(time_source_house);
	randomize();
	placing_house = instance_create_layer(
		x,
		y,
		"Instances",
		obj_house, 
		{
			building_duration: placing_house_duration,
			network_id: md5_string_unicode(get_timer() + irandom_range(1, 999999))
		}
	);
	show_debug_message(variable_instance_get(placing_house, "network_id"));
	send_network_data(json_stringify({
		type: "create_house",
		network_id: variable_instance_get(placing_house, "network_id"),
		x: x,
		y: y
	}));
}

function place_bomb () {
	var restore_bomb = function restore_bomb () {
		var erase_explosion = function erase_explosion () {
		//	instance_destroy(explosion);
		}

		time_source_bomb = false;
		//var explosion = instance_create_layer(
	//		active_bomb.x + active_bomb.sprite_width / 2 - sprite_get_width(spr_explosion) / 2,
	//		active_bomb.y + active_bomb.sprite_height / 2 - sprite_get_height(spr_explosion) / 2,
	//		"Instances",
	//		obj_explosion
	//	);

		if (!is_main_player) exit;
		instance_destroy(active_bomb);
	
		//var time_source_explosion = time_source_create(time_source_game, 1, time_source_units_seconds, erase_explosion, [explosion]);
		//time_source_start(time_source_explosion);
		
		send_network_data(json_stringify({
			type: "detonate_bomb",
			network_id: variable_instance_get(active_bomb, "network_id"),
			x: x,
			y: y
		}));
		
		active_bomb = false;
	}
	
	randomize();
	time_source_bomb = time_source_create(time_source_game, bomb_fuse_delay, time_source_units_seconds, restore_bomb);
	time_source_start(time_source_bomb);
	active_bomb = instance_create_layer(
		x + sprite_width / 2 - sprite_get_width(spr_bomb) / 2,
		y + sprite_height / 2 - sprite_get_height(spr_bomb) / 2,
		"effects",
		obj_buble,
		{network_id: md5_string_unicode(get_timer() + irandom_range(1, 999999))}
	);
	active_bomb.direcao = playerDirecao;
	
	send_network_data(json_stringify({
		type: "place_bomb",
		network_id: variable_instance_get(active_bomb, "network_id"),
		x: x,
		y: y
	}));
}

function add_to_score (amt_to_add) {
	score = score + amt_to_add;
	send_network_data(json_stringify({
		type: "score"
	}));
}