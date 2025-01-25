/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (time_source_house && time_source_get_time_remaining(time_source_house) <= 0) {
	time_source_destroy(time_source_house);
	time_source_house = false;
} else if (time_source_house) {
	variable_instance_set(id, "health", (building_duration - time_source_get_time_remaining(time_source_house)) * 100);
}

draw_healthbar(
	x - 10,
	y - 15,
	x + 55,
	y - 5,
	variable_instance_get(id, "health"),
	c_black,
	c_red,
	c_green,
	0,
	true,
	true
);
