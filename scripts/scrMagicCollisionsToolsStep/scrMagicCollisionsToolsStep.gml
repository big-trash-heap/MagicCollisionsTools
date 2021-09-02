
function magCollsStepW(_x, _y, _object, _speed, _check, _data) {
	
	static _find_left = function(_left, _inst) {
		
		return min(_left, _inst.bbox_left);
	}
	
	static _find_right = function(_right, _inst) {
		
		return max(_right, _inst.bbox_right);
	}
	
	var _step, _find_f, _find_v;
	if (_speed < 0) {
		
		_step   = -self.sprite_width;
		_find_f = _find_right;
		_find_v = -infinity;
	}
	else {
		
		_step   = self.sprite_width;
		_find_f = _find_left;
		_find_v = infinity;
	}
	
	ds_list_clear(global.__magCollsStepList);
	
	var _size = 0;
	var _div = floor(_speed / _step);
	if (_div) {
		
		var _iter = _step;
		do {
			
			_size = instance_place_list(_x + _iter, _y, _object, global.__magCollsStepList, false);
			if (_size) break;
			
			_iter += _step;
		} until (--_div == 0);
	}
	
	if (_size == 0) {
		
		_size = instance_place_list(_x + _speed, _y, _object, global.__magCollsStepList, false);
	}
	
	if (_size) {
		
		if (!is_undefined(_check)) {
			
			do {
				_iter = global.__magCollsStepList[| --_size];
				if (_check(_iter, _data)) _find_v = _find_f(_find_v, _iter);
			} until (_size == 0);
			
			if (!is_infinity(_find_v)) {
				
				if (_speed < 0) 
					global.magCollsDist = (_find_v - self.bbox_left + 1);
				else
					global.magCollsDist = (_find_v - self.bbox_right - 1);
				
				return true;
			}
		}
		else {
			
			do {
				_find_v = _find_f(_find_v, global.__magCollsStepList[| --_size]);
			} until (_size == 0);
			
			if (_speed < 0) 
				global.magCollsDist = (_find_v - self.bbox_left + 1);
			else
				global.magCollsDist = (_find_v - self.bbox_right - 1);
			
			return true;
		}
	}
	
	global.magCollsDist = _speed;
	return false;
}

function magCollsStepH(_x, _y, _object, _speed, _check, _data) {
	
	static _find_top = function(_top, _inst) {
		
		return min(_top, _inst.bbox_top);
	}
	
	static _find_bottom = function(_bottom, _inst) {
		
		return max(_bottom, _inst.bbox_bottom);
	}
	
	var _step, _find_f, _find_v;
	if (_speed < 0) {
		
		_step   = -self.sprite_height;
		_find_f = _find_bottom;
		_find_v = -infinity;
	}
	else {
		
		_step   = self.sprite_height;
		_find_f = _find_top;
		_find_v = infinity;
	}
	
	ds_list_clear(global.__magCollsStepList);
	
	var _size = 0;
	var _div = floor(_speed / _step);
	if (_div) {
		
		var _iter = _step;
		do {
			
			_size = instance_place_list(_x, _y + _iter, _object, global.__magCollsStepList, false);
			if (_size) break;
			
			_iter += _step;
		} until (--_div == 0);
	}
	
	if (_size == 0) {
		
		_size = instance_place_list(_x, _y + _speed, _object, global.__magCollsStepList, false);
	}
	
	if (_size) {
		
		if (!is_undefined(_check)) {
			
			do {
				_iter = global.__magCollsStepList[| --_size];
				if (_check(_iter, _data)) _find_v = _find_f(_find_v, _iter);
			} until (_size == 0);
			
			if (!is_infinity(_find_v)) {
				
				if (_speed < 0) 
					global.magCollsDist = (_find_v - self.bbox_top + 1);
				else
					global.magCollsDist = (_find_v - self.bbox_bottom - 1);
				
				return true;
			}
		}
		else {
			
			do {
				_find_v = _find_f(_find_v, global.__magCollsStepList[| --_size]);
			} until (_size == 0);
			
			if (_speed < 0) 
				global.magCollsDist = (_find_v - self.bbox_top + 1);
			else
				global.magCollsDist = (_find_v - self.bbox_bottom - 1);
			
			return true;
		}
	}
	
	global.magCollsDist = _speed;
	return false;
}

#region 

global.__magCollsStepList = ds_list_create();

#endregion
