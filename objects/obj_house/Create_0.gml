/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

is_building = true;
time_source_house = time_source_create(time_source_game, building_duration, time_source_units_seconds, function () {
	is_building = false;
});
time_source_start(time_source_house);

