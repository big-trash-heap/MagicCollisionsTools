

//
#macro MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID	false

//
#macro MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_FIXANGLE	true


#region PREPROCESSOR

if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
	global.magCollsSampleId = noone;
}

#endregion


#region line

function magCollsJumpLine(_x1, _y1, _x2, _y2, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check = method(global.__magCollsJumpSampleObject,
		function(_speed, _object) {
			
			_object = collision_line(
				self._x1, self._y1,
				self._x1 + lengthdir_x(_speed, self._dir),
					self._y1 + lengthdir_y(_speed, self._dir),
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsSampleId = _object;
			}
			return _object;
		});
		
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsSampleId = noone;
	}
	
	global.magCollsDir = point_direction(_x1, _y1, _x2, _y2);
	
	global.__magCollsJumpSampleObject._x1    = _x1;
	global.__magCollsJumpSampleObject._y1    = _y1;
	global.__magCollsJumpSampleObject._dir   = global.magCollsDir;
	global.__magCollsJumpSampleObject._prec  = _prec;
	global.__magCollsJumpSampleObject._notme = _notme;
	
	_x2 = point_distance(_x1, _y1, _x2, _y2);
	_y2 = magCollsJump(_x2, _check, _obj, _accuracy);
	
	if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_FIXANGLE) {
		
		if (_y2) {
			
			_x1 = _x1 + lengthdir_x(global.magCollsDis, global.magCollsDir);
			_y1 = _y1 + lengthdir_y(global.magCollsDis, global.magCollsDir);
			
			if (!collision_circle(_x1, _y1, 1.7 + _accuracy, _obj, _prec, _notme)) {
				
				global.magCollsDis = _x2;
				
				if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
					global.magCollsSampleId = noone;
				}
				
				return false;
			}
		}
	}
	
	return _y2;
}

#endregion

#region rectangle

function magCollsJumpRectW(_x1, _y1, _y2, _width, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check_xp = method(global.__magCollsJumpSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1,
				self._x1 + _speed, self._z,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsSampleId = _object;
			}
			return _object;
		});
	
	static _check_xm = method(global.__magCollsJumpSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1 - _speed, self._y1,
				self._x1, self._z,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsSampleId = _object;
			}
			return _object;
		});
	
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsSampleId = noone;
	}
	
	global.__magCollsJumpSampleObject._x1    = _x1;
	global.__magCollsJumpSampleObject._y1    = _y1;
	global.__magCollsJumpSampleObject._z     = _y2;
	global.__magCollsJumpSampleObject._prec  = _prec;
	global.__magCollsJumpSampleObject._notme = _notme;
	
	_x1 = sign(_width);
	_y1 = magCollsJump(abs(_width), (_x1 ? _check_xp : _check_xm), _obj, _accuracy);
	
	global.magCollsDis *= _x1;
	return _y1;
}

function magCollsJumpRectH(_x1, _y1, _x2, _height, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check_yp = method(global.__magCollsJumpSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1,
				self._z, self._y1 + _speed,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsSampleId = _object;
			}
			return _object;
		});
	
	static _check_ym = method(global.__magCollsJumpSampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1 - _speed,
				self._z, self._y1,
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsSampleId = _object;
			}
			return _object;
		});
	
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsSampleId = noone;
	}
	
	global.__magCollsJumpSampleObject._x1    = _x1;
	global.__magCollsJumpSampleObject._y1    = _y1;
	global.__magCollsJumpSampleObject._z     = _x2;
	global.__magCollsJumpSampleObject._prec  = _prec;
	global.__magCollsJumpSampleObject._notme = _notme;
	
	_x1 = sign(_height);
	_y1 = magCollsJump(abs(_height), (_x1 ? _check_yp : _check_ym), _obj, _accuracy);
	
	global.magCollsDis *= _x1;
	return _y1;
}

#endregion

#region circle

function magCollsJumpCircle(_x, _y, _rad, _obj, _prec=false, _notme=false, _accuracy=MAGIC_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _check = method(global.__magCollsJumpSampleObject,
		function(_speed, _object) {
			
			_object = collision_circle(
				self._x1, self._y1,
				_speed, _object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsSampleId = _object;
			}
			return _object;
		});
	
	if (MAGIC_COLLISION_JUMPSAMPLE_PREPROCESSOR_GETID) {
	
		global.magCollsSampleId = noone;
	}
	
	global.__magCollsJumpSampleObject._x1    = _x;
	global.__magCollsJumpSampleObject._y1    = _y;
	global.__magCollsJumpSampleObject._z     = _rad;
	global.__magCollsJumpSampleObject._prec  = _prec;
	global.__magCollsJumpSampleObject._notme = _notme;
	
	return magCollsJump(_rad, _check, _obj, _accuracy);
}

#endregion


#region __object

global.__magCollsJumpSampleObject = {};

#endregion

