/// @DnDAction : YoYo Games.Instances.Inherit_Event
/// @DnDVersion : 1
/// @DnDHash : 18B0318E
/// @DnDApplyTo : {obj_button_parent}
with(obj_button_parent) event_inherited();

/// @DnDAction : YoYo Games.Instances.If_Instance_Exists
/// @DnDVersion : 1
/// @DnDHash : 36A86780
/// @DnDArgument : "obj" "obj_button_controls"
/// @DnDSaveInfo : "obj" "obj_button_controls"
var l36A86780_0 = false;l36A86780_0 = instance_exists(obj_button_controls);if(l36A86780_0){	/// @DnDAction : YoYo Games.Instances.Destroy_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 4A639617
	/// @DnDApplyTo : {obj_button_controls}
	/// @DnDParent : 36A86780
	with(obj_button_controls) instance_destroy();}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 5B27E700
else{	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 60E753DD
	/// @DnDApplyTo : {obj_button_parent}
	/// @DnDParent : 5B27E700
	/// @DnDArgument : "xpos" "room_width / 2"
	/// @DnDArgument : "ypos" "room_height  -150"
	/// @DnDArgument : "objectid" "obj_button_controls"
	/// @DnDArgument : "layer" ""tutorial""
	/// @DnDSaveInfo : "objectid" "obj_button_controls"
	with(obj_button_parent) {
		instance_create_layer(room_width / 2, room_height  -150, "tutorial", obj_button_controls); 
	}}