
var _key_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _key_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var _speed = (keyboard_check(vk_control) ? 8 : 0.1);

show_debug_message(_key_x);
show_debug_message(_key_y);

if (_key_x != 0) {
	
	magicCollsMove_double(_key_x * _speed, 0.1, 20, self.check_x);
	
	x += magicCollsSpeed;
}

if (_key_y != 0) {
	
	magicCollsMove_double(_key_y * _speed, 0.1, 20, self.check_y);
	
	y += magicCollsSpeed;
}
