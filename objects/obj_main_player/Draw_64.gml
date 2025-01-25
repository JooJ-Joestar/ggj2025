/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (cutting_tree && time_source_tree) {
	var amount = (cutting_tree_duration - time_source_get_time_remaining(time_source_tree)) * 100;
	draw_healthbar(
		x - 10,
		y - 15,
		x + 55,
		y - 5,
		amount,
		c_black,
		#1ac1dd,
		#1ac1dd,
		0,
		true,
		true
	);
}

if (!is_main_player || !global.debug || !struct_exists(global, "txt_server_status")) exit;
draw_set_halign(fa_center);
draw_text(x + id.sprite_width / 2, y + id.sprite_height + 5, "Steve Agiota");
draw_set_halign(fa_left);
draw_text(0, 0, global.txt_server_status);