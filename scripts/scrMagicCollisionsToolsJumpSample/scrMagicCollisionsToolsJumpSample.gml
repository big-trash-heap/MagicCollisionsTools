
#macro MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETID		false
#macro MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_FIXANGLE	true

if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETID) {
	
	global.magCollsSampleId = noone;
}

function magCollsJumpLine(_x1, _y1, _x2, _y2, _obj, _prec=false, _notme=false, _accuracy=1) {
	static _space = {_x1: 0, _y1: 0, _dir: 0, _prec: false, _notme: false};
	static _check = method(
		_space,
		function(_speed, _object) {
			
			_object = collision_line(
				self._x1, self._y1,
				self._x1 + lengthdir_x(_speed, self._dir),
					self._y1 + lengthdir_y(_speed, self._dir),
				_object, self._prec, self._notme
			);
			
			if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETID) {
				
				if (_object) global.magCollsSampleId = _object;
			}
			return _object;
		});
		
	if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETID) {
	
		global.magCollsSampleId = noone;
	}
	
	global.magCollsDir = point_direction(_x1, _y1, _x2, _y2);
	
	_space._x1    = _x1;
	_space._y1    = _y1;
	_space._dir   = global.magCollsDir;
	_space._prec  = _prec;
	_space._notme = _notme;
	
	_x2 = point_distance(_x1, _y1, _x2, _y2);
	_y2 = magCollsJump(_x2, _check, _obj, _accuracy);
	
	if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_FIXANGLE) {
		
		if (_y2) {
			
			_x1 = _x1 + lengthdir_x(global.magCollsDis, global.magCollsDir);
			_y1 = _y1 + lengthdir_y(global.magCollsDis, global.magCollsDir);
			
			if (!collision_circle(_x1, _y1, 1.7 + _accuracy, _obj, _prec, _notme)) {
				
				global.magCollsDis = _x2;
				
				if (MAGIC_COLLISION_JUMPLINE_PREPROCESSOR_GETID) {
				
					global.magCollsSampleId = noone;
				}
				
				return false;
			}
		}
	}
	
	return _y2;
}
