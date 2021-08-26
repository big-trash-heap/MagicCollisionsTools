
self.check_x = function(_speed) {
	
	return place_meeting(x + _speed, y, obj_wall);
}

self.check_y = function(_speed) {
	
	return place_meeting(x, y + _speed, obj_wall);
}

