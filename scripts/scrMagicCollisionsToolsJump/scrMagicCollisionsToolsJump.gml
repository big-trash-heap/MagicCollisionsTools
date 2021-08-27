
#macro MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY	0.8

function magCollsJump(_speed, _check, _data, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	if (_check(_speed, _data)) {
		
		_speed /= 2;
		var _mathSpeed = _speed;
		
		while (_speed > _accuracy) {
			
			_speed /= 2;
			if (_check(_mathSpeed, _data))
				_mathSpeed -= _speed;
			else
				_mathSpeed += _speed;
		}
		
		global.magCollsDis = _mathSpeed;
		return true;
	}
	
	global.magCollsDis = _speed;
	return false;
}
