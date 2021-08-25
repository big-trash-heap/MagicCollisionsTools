
var _key_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _key_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var _speed = (keyboard_check(vk_control) ? 8 : 0.1);
	
if (_key_x != 0) {
	
	magicCollsMove_double(x, y, _key_x * _speed, 0.1, 20, function(_speed) {
		
		return place_meeting(x + _speed, y, obj_wall);
	});
	
	x += magicCollsMap[? "speed"];
}

if (_key_y != 0) {
	
	magicCollsMove_double(x, y, _key_y * _speed, 0.1, 20, function(_speed) {
		
		return place_meeting(x, y + _speed, obj_wall);
	});
	
	y += magicCollsMap[? "speed"];
}