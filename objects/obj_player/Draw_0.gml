
draw_set_color(c_yellow);

switch (self.state) {
case state.tds0:
	draw_self();
	draw_text(0, 0, "TDS 0");
	
	if (magCollsJumpLine(self.x, self.y, mouse_x, mouse_y, obj_wall))
		draw_set_color(c_red);
	else
		draw_set_color(c_lime);
	
	var _dir = point_direction(self.x, self.y, mouse_x, mouse_y);
	draw_line(
		self.x, self.y,
		self.x + lengthdir_x(global.magCollsDist, _dir),
			self.y + lengthdir_y(global.magCollsDist, _dir)
	);
	break;
case state.tds1:
	draw_self();
	draw_text(0, 0, "TDS 1");
	
	if (magCollsJumpCircle(x, y, 128, obj_wall))
		draw_set_color(c_red);
	else
		draw_set_color(c_lime);
	
	draw_circle(x, y, global.magCollsDist, true);
	break;
case state.plt0:
	draw_self();
	draw_text(0, 0, "PLT 0");
	
	if (magCollsJumpRectW(x, y - 31, y + 31, 256 * sign(mouse_x - x), obj_wall))
		draw_set_color(c_red);
	else
		draw_set_color(c_lime);
	
	draw_rectangle(x, y - 31, x + global.magCollsDist, y + 31, true);
	
	if (magCollsJumpRectH(x - 31, y, x + 31, 256 * sign(mouse_y - y), obj_wall))
		draw_set_color(c_red);
	else
		draw_set_color(c_lime);
	
	draw_rectangle(x - 31, y, x + 31, y + global.magCollsDist, true);
	break;
case state.plt1:
	draw_self();
	draw_text(0, 0, "PLT 1");
}
