/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

list = ds_list_create();
num = instance_place_list(x, y, obj_house, list, false);

if (num > 0) {
    for (var i = 0; i < num; ++i;) {
		show_debug_message(variable_instance_get(list[| i], "health"));
		variable_instance_set(list[| i], "health", variable_instance_get(list [| i], "health") - 40);
    }
}

ds_list_destroy(list);