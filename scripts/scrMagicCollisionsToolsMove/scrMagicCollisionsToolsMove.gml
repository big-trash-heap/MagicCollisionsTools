
//
#macro PREPROCESSOR_MAGIC_COLLISION_MOVE_CHECKZERO false

/*
	
*/

function magicCollsMove_single(_x, _y, _speed, _accuracy, _check, _check_data) {
	
	//
	magicCollsMap[? "speed"] = 0;
	
	//
	if (PREPROCESSOR_MAGIC_COLLISION_MOVE_CHECKZERO) {
	
		if (_check(0, _x, _y, _check_data)) return true;
	}
	
	//
	var _sign = sign(_speed);
	var _math = floor(abs(_speed) / _accuracy);
	var _iter = 0;
	repeat _math {
		
		//
		_iter += _accuracy;
		_math  = _iter * _sign;
		
		//
		if (_check(_math, _x, _y, _check_data)) return true;
		magicCollsMap[? "speed"] = _math;
	}
	
	//
	if (_check(_speed, _x, _y, _check_data)) return true;
	magicCollsMap[? "speed"] = _speed;
	
	//
	return false;
}

function magicCollsMove_double(_x, _y, _speed, _accuracy_micro, _accuracy_macro, _check, _check_data) {
	
	//
	magicCollsMap[? "speed"] = 0;
	
	//
	if (PREPROCESSOR_MAGIC_COLLISION_MOVE_CHECKZERO) {
	
		if (_check(0, _x, _y, _check_data)) return true;
	}
	
	//
	var _sign = sign(_speed);
	var _abs  = abs(_speed);
	var _div  = floor(_abs / _accuracy_macro);
	var _math = 0;
	var _iter = 0;
	repeat _div {
		
		//
		_iter += _accuracy_macro;
		_math  = _iter * _sign;
		
		//
		if (_check(_math, _x, _y, _check_data)) {
			
			//
			do {
				_iter -= _accuracy_micro;
				_math  = _iter * _sign;
			} until (!_check(_math, _x, _y, _check_data));
			
			//
			magicCollsMap[? "speed"] = _math;
			return true;
		}
	}
	
	//
	magicCollsMap[? "speed"] = _math;
	
	//
	repeat floor((_abs - _div * _accuracy_macro) / _accuracy_micro) {
		
		//
		_iter += _accuracy_micro;
		_math  = _iter * _sign;
		
		//
		if (_check(_math, _x, _y, _check_data)) return true;
		magicCollsMap[? "speed"] = _math;
	}
	
	//
	if (_check(_speed, _x, _y, _check_data)) return true;
	magicCollsMap[? "speed"] = _speed;
	
	//
	return false;
}
