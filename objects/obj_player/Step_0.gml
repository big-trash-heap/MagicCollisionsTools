
if (keyboard_check(ord("1")))
	self.state = state.tds0;

if (keyboard_check(ord("2")))
	self.state = state.tds1;

if (keyboard_check(ord("3")))
	self.state = state.plt0;

if (keyboard_check(ord("4")))
	self.state = state.plt1;

switch (self.state) {
case state.tds0:
	var _key_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var _key_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	var _speed = (keyboard_check(vk_control) ? 0.1 : 4);
	
	if (_key_x != 0) {
	
		magCollsMove_double(_key_x * _speed, 1, 30, self.check_x);
		self.x += global.magCollsDist;
	}
	
	if (_key_y != 0) {
	
		magCollsMove_double(_key_y * _speed, 1, 30, self.check_y);
		self.y += global.magCollsDist;
	}
	break;
case state.tds1:
	var _key_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var _key_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
	
	if (_key_x != 0) {
		
		self.press_dir = 0;
		if (self.check_v(_key_x)) _key_x = 0;
	}
	if (_key_y != 0) {
		
		self.press_dir = 270;
		if (self.check_v(_key_y)) _key_y = 0;
	}
	
	if (_key_x != 0 or _key_y != 0) {
		
		self.press_dir = point_direction(0, 0, _key_x, _key_y);
		var _speed = (keyboard_check(vk_control) ? 0.1 : 4);
		if (!self.check_v(1)) {
			
			magCollsMove_single(_speed, 4, self.check_v);
			self.x += lengthdir_x(global.magCollsDist, self.press_dir);
			self.y += lengthdir_y(global.magCollsDist, self.press_dir);
		}
	}
	break;
case state.plt0:
	
	var _grav_enable = !self.check_y(1);
	if (_grav_enable) 
		self.grav += 1;
	else {
		
		if (keyboard_check_pressed(ord("W")))
			self.grav = -22;
	}
	var _key_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var _speed = (keyboard_check(vk_control) ? 0.1 : 4);
	
	if (_key_x != 0) {
	
		magCollsMove_double(_key_x * _speed, 1, 30, self.check_x);
		self.x += global.magCollsDist;
	}
	
	if (self.grav != 0) {
	
		if (magCollsMove_double(self.grav, 1, 30, self.check_y)) {
			
			self.grav = 0;
		}
		self.y += global.magCollsDist;
	}
	break;
case state.plt1:
	self.press_dir = 270;
	var _grav_enable = !self.check_v(1);
	if (_grav_enable)
		self.grav += 1;
	else {
		
		if (keyboard_check_pressed(ord("W")))
			self.grav = -22;
	}
	
	self.press_dir = 0;
	
	var _dir = undefined, _dis;
	var _key_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	if (_key_x != 0) {
		
		var _speed = (keyboard_check(vk_control) ? 0.1 : 4);
		if (!self.check_v(_key_x)) {
			_speed *= _key_x;
			
			_dir = point_direction(0, 0, _speed, self.grav);
			_dis = point_distance(0, 0, _speed, self.grav);
		}
	}
	
	if (is_undefined(_dir)) {
		
		_dir = (sign(self.grav) == -1 ? 90 : 270);
		_dis = abs(self.grav);
	}
	
	self.press_dir = _dir;
	var _check = magCollsMove_single(_dis, 1, self.check_v);
	self.x += lengthdir_x(global.magCollsDist, self.press_dir);
	self.y += lengthdir_y(global.magCollsDist, self.press_dir);
	if (_check) {
		self.press_dir = 270;
		if (self.check_v(sign(self.grav))) {
			
			self.grav = 0;
		}
	}
	break;
}
