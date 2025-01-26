var _x1 = 100;
var _y1 = 700;
var _escala = 1;
var _sprite_size = sprite_get_width(spr_joystick);

draw_sprite_ext(spr_joystick, 0, _x1, _y1, _escala, _escala, 0, c_white, .2);

var _mouse_x = device_mouse_x_to_gui(0);
var _mouse_y = device_mouse_y_to_gui(0);
var mouse_sobre = point_in_circle(_mouse_x, _mouse_y, _x1, _y1, (_sprite_size/2) * _escala);
var mouse_click = mouse_check_button(mb_left);

if (mouse_sobre || act) 
{
	if (mouse_click)
	{
		global.main_player.joystick_moved = true;
		act = true;
		vel = min(point_distance(_x1, _y1, _mouse_x, _mouse_y), (_sprite_size/2) * _escala);
		dir = point_direction(_x1, _y1, _mouse_x, _mouse_y);
	}
}

if (!mouse_click) 
{
	act = false;
	vel = lerp(vel, 0, .1);
	global.main_player.joystick_moved = false;
}

var _x2 = lengthdir_x(vel, dir);
var _y2 = lengthdir_y(vel, dir);

if (true)
{
	var _val_max = (_sprite_size/2) * _escala;
	var _velh = (_x2 / _val_max) * max_val;
	var _velv = (_y2 / _val_max) * max_val;
	
	global.main_player.hsp = _velh;
	global.main_player.vsp = _velv;
	
}
// desenha a bolinha menor dentro da grnade
draw_sprite_ext(spr_joystick, 0, _x1 + _x2, _y1 + _y2, _escala/4, _escala/4, 0, c_blue, .8);
