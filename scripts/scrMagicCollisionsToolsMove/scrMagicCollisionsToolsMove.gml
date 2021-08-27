
//
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKZERO			false
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN			true
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN_ACCURACY false

/*
	
*/

function magCollsMove_single(_speed, _accuracy, _check, _data) {
	
	//
	global.magCollsDis = 0;
	
	//
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKZERO) {
	
		if (_check(0, _data)) return true;
	}
	
	//
	var _sign = sign(_speed);
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN) {
		if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN_ACCURACY) {
		
			if (_check(_sign * _accuracy, _data)) return true;
		}
		else {
			
			if (_check(_sign, _data)) return true;
		}
	}
	
	//
	var _math = floor(abs(_speed) / _accuracy);
	var _iter = 0;
	repeat _math {
		
		//
		_iter += _accuracy;
		_math  = _iter * _sign;
		
		//
		if (_check(_math, _data)) return true;
		global.magCollsDis = _math;
	}
	
	//
	if (_check(_speed, _data)) return true;
	global.magCollsDis = _speed;
	
	//
	return false;
}

function magCollsMove_double(_speed, _accuracyMicro, _accuracyMacro, _check, _data) {
	
	//
	global.magCollsDis = 0;
	
	//
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKZERO) {
	
		if (_check(0, _data)) return true;
	}
	
	//
	var _sign = sign(_speed);
	if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN) {
		if (MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN_ACCURACY) {
		
			if (_check(_sign * _accuracyMicro, _data)) return true;
		}
		else {
			
			if (_check(_sign, _data)) return true;
		}
	}
	
	//
	var _abs  = abs(_speed);
	var _div  = floor(_abs / _accuracyMacro);
	var _math = 0;
	var _iter = 0;
	repeat _div {
		
		//
		_iter += _accuracyMacro;
		_math  = _iter * _sign;
		
		//
		if (_check(_math, _data)) {
			
			//
			do {
				_iter -= _accuracyMicro;
				_math  = _iter * _sign;
			} until (!_check(_math, _data));
			
			//
			global.magCollsDis = _math;
			return true;
		}
	}
	
	//
	global.magCollsDis = _math;
	
	//
	repeat floor((_abs - _div * _accuracyMacro) / _accuracyMicro) {
		
		//
		_iter += _accuracyMicro;
		_math  = _iter * _sign;
		
		//
		if (_check(_math, _data)) return true;
		global.magCollsDis = _math;
	}
	
	//
	if (_check(_speed, _data)) return true;
	global.magCollsDis = _speed;
	
	//
	return false;
}
