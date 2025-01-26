/// @description Receive network data
// Você pode escrever seu código neste editor

// show_debug_message("Reading async networking");
/*var json_async_load = json_encode(async_load);
show_debug_message(json_async_load);*/

if (!is_main_player) exit;

function move (target_player, new_x, new_y) {
	player_list[target_player].x = new_x;
	player_list[target_player].y = new_y;
}

if (async_load[? "size"] > 0) {
	try {
		var buff = async_load[? "buffer"];
		buffer_seek(buff, buffer_seek_start, 0);
		var response = buffer_read(buff, buffer_string);
		//show_debug_message(response);
		var response_struct = json_parse(response);
		//show_debug_message(response_struct);
	
		if (struct_exists(response_struct, "type") == true) {
			switch (response_struct.type) {
				case "keep_alive":
					global.txt_server_status = "Connected";
					alarm[0] = game_get_speed(gamespeed_fps) * 1;
					alarm[1] = game_get_speed(gamespeed_fps) * 2;
				break;
			
				case "load_instances":
					player_server_id = response_struct.own_id;
					array_foreach(response_struct.players, function (_element, _index) {
						if (player_server_id == _element.id) return;
						player_list[_element.id] = instance_create_layer(
							_element.x,
							_element.y,
							"Instances",
							obj_main_player,
							{is_main_player: false}
						);
					});
				
					//array_foreach (response_struct.trees, function (_element, _index) {
					//	show_debug_message(_element);
				//		tree = instance_create_layer(
				//			_element.x,
				//			_element.y,
				//			"Instances",
				//			obj_tree
				//		);
				//		variable_instance_set(tree, "network_id", _element.network_id);
				//		show_debug_message(variable_instance_get(tree, "network_id"));
				//	});
				break;
			
				case "new_player":
					player_list[response_struct.id] = instance_create_layer(
						response_struct.x,
						response_struct.y,
						"Instances",
						obj_main_player,
						{is_main_player: false}
					);
				break;
			
				case "fishing_spots":
					instance_destroy(TestePescaOBJ);
				
					array_foreach(response_struct.fishing_spots, function (_element, _index) {
						instance_create_layer(
							_element.x,
							_element.y,
							"Instances",
							TestePescaOBJ
						);
					});
				break;
			
				case "move":
					move(response_struct.id, response_struct.x, response_struct.y);
				break;
			
				case "place_bomb":
					player = player_list[response_struct.id];
					player.place_bomb();
				break;
			
				case "timer":
					match_timer = response_struct.timer;
					match_status = response_struct.match_status;
				
					if (match_status = "score") {
						score = 0;
						scoreboard = response_struct.final_score.fmt_score;
					}
				break;
			
			//	case "cut_tree":
			//		for (var i = 0; i < instance_number(obj_tree); ++i;) {
			//			tree = instance_find(obj_tree, i);
			//			if (tree.network_id == response_struct.tree_network_id) break;
			//			tree = false;
			//		}
			//		if (!tree) break;
			//		instance_destroy(tree);
			//	break;
			
				case "disconnect":
					instance_destroy(player_list[response_struct.id]);
					array_delete(player_list, response_struct.id, 1);
				break;
			}
		}
	} catch (error) {
	
	}
}