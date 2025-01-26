/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//if (cutting_tree && time_source_tree) {
//	var amount = (cutting_tree_duration - time_source_get_time_remaining(time_source_tree)) * 100;
//	draw_healthbar(
//		x - 10,
//		y - 15,
//		x + 55,
//		y - 5,
//		amount,
//		c_black,
//		#1ac1dd,
//		#1ac1dd,
//		0,
//		true,
//		true
//	);
//}

if (!is_main_player || !global.debug || !struct_exists(global, "txt_server_status")) exit;
draw_set_halign(fa_center);
draw_text(x, y, "Steve Agiota");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_transformed(0, 20, "Tempo: " + string(match_timer), 1.5, 1.5, 0);
draw_text_transformed(0, 50, "Pontuacao: " + string(score), 1.5, 1.5, 0);
draw_text_transformed(0, 80, "Peixe 1 x" + string(quantidade_one), 1.5, 1.5, 0);
draw_text_transformed(0, 110, "Peixe 2 x" + string(quantidade_two), 1.5, 1.5, 0);
draw_text_transformed(0, 140, "Peixe 3 x" + string(quantidade_three), 1.5, 1.5, 0);

draw_set_halign(fa_left);
draw_text(0, 0, global.txt_server_status);
