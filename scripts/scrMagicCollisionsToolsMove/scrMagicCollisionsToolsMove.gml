
/*
	Настройки работы функций
	
	Так как эти функции не являются критически важными, а скорее удобным дополнением,
	то я вынес их в "препросессор", а не добавил как переключаемые аргументы
*/

															// первоначальная проверка столкновение, со скоросью 0
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKZERO			false
															
															// первоначальная проверка столкновение, со скоростью равным знаку "скорости"
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN			false
															// использовать ли для этой проверки указанную точность
#macro MAGIC_COLLISION_MOVE_PREPROCESSOR_CHECKSIGN_ACCURACY false

/*
	Данные функции позволяют проверить столкновение симулируя пошаговое движение
	
	В качестве проверки столкновение выступает функция check, которая должна вернуть true/false
	(true - есть столкновение)
	
	Обе функции вернут true при наличии столкновения, и false при его отсутствии
	Так же, они запишут последнею "свободную" скорость в переменную global.magCollsDist
	(под свободной я подразумеваю, скорость при которой столкновения нету)
*/

// check = check(speed, data)

/// @function		magCollsMove_single(speed, accuracy, check, [data]);
function magCollsMove_single(_speed, _accuracy, _check, _data) {
	
	//
	global.magCollsDist = 0;
	
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
		global.magCollsDist = _math;
	}
	
	//
	if (_check(_speed, _data)) return true;
	global.magCollsDist = _speed;
	
	//
	return false;
}

/// @function		magCollsMove_double(speed, accuracy_micro, accuracy_macro, check, [data]);
/// @description	В качестве шага для проверки столкновения будет использовать accuracy_macro
//					При наличии столкновения, уточнит его с помощью accuracy_micro
function magCollsMove_double(_speed, _accuracyMicro, _accuracyMacro, _check, _data) {
	
	//
	global.magCollsDist = 0;
	
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
			global.magCollsDist = _math;
			return true;
		}
	}
	
	//
	global.magCollsDist = _math;
	
	//
	repeat floor((_abs - _div * _accuracyMacro) / _accuracyMicro) {
		
		//
		_iter += _accuracyMicro;
		_math  = _iter * _sign;
		
		//
		if (_check(_math, _data)) return true;
		global.magCollsDist = _math;
	}
	
	//
	if (_check(_speed, _data)) return true;
	global.magCollsDist = _speed;
	
	//
	return false;
}

