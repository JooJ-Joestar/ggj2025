/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (other.id == active_bomb.id) exit;

if (move_speed > 0) {
	audio_play_sound(snd_bonk, 10, false);
}

if (time_source_fucked) {
	time_source_destroy(time_source_fucked);
}

var revive = function revive () {
	image_index = 0;
	move_speed = original_move_speed;
}

move_speed = 0;
image_index = 3

time_source_fucked = time_source_create(time_source_game, fucked_timeout, time_source_units_seconds, revive);
time_source_start(time_source_fucked);