
if (magCollsJumpLine(self.x, self.y, mouse_x, mouse_y, obj_wall))
	draw_set_color(c_red);
else
	draw_set_color(c_lime);

draw_line(
	self.x, self.y,
	self.x + lengthdir_x(global.magCollsDis, global.magCollsDir),
		self.y + lengthdir_y(global.magCollsDis, global.magCollsDir)
);

draw_self();
draw_text(0, 0, [global.magCollsDis]);
