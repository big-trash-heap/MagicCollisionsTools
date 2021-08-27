
function magCollsJump(_speed, _check, _data, _accuracy=1) {
	
	show_debug_message("Check begin")
	if (_check(_speed, _data)) {
		
		_speed /= 2;
		var _mathSpeed = _speed;
		
		while (_speed > _accuracy) {
			
			var v= _check(_mathSpeed, _data);
			_speed /= 2;
			if (v)
				_mathSpeed -= _speed;
			else
				_mathSpeed += _speed;
			
			show_debug_message([v, _mathSpeed])
		}
		show_debug_message("COL");
		global.magCollsDis = _mathSpeed;
		return true;
	}
	show_debug_message("NO COL");
	global.magCollsDis = _speed;
	return false;
}
