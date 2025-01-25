/// @description Connect to server

if (!is_main_player) exit;

if (!variable_instance_exists(id, "player_buffer")) {
	player_buffer = buffer_create(1000, buffer_fixed, 1000);
}

if (!variable_instance_exists(id, "client")) {
	client = network_create_socket(network_socket_ws);
}


if (!variable_instance_exists(id, "connection")) {
	var server = "localhost";
	var port = 3000;
	global.txt_server_status = "Connecting to server " + server + ":" + string(port);
	connection = network_connect_raw_async(client, server, port);
}