
/*
	Управление:
	1, 2, 3, 4 - переключение режимов
	
	TDS:
	W, A, S, D - движение
	
	PLT:
	W - прыжок 
	A, D - движение
*/

//
enum state { tds0, tds1, plt0, plt1 } ;
self.state = -1;

#region tds0/plt0

self.check_x = function(_speed) {
	
	return place_meeting(self.x + _speed, self.y, obj_wall);
}

self.check_y = function(_speed) {
	
	return place_meeting(self.x, self.y + _speed, obj_wall);
}

#endregion tds0

#region tds1/plt1

self.press_dir = 0;
self.check_v = function(_speed) {
	
	return place_meeting(
		self.x + lengthdir_x(_speed, self.press_dir),
		self.y + lengthdir_y(_speed, self.press_dir), obj_wall);
}

#endregion

#region plt

self.grav = 0;

#endregion

self.depth = -1;
