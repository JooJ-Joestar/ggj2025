/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

send_network_data(json_stringify({type: "keep_alive"}));
global.txt_server_status = "Waiting keep alive from server";
alarm[1] = game_get_speed(gamespeed_fps) * 1;