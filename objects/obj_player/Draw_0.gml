
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

draw_set_color(c_blue);

magCollsJumpRectW(x, y, y + 64, 1024 * sign(mouse_x - x), obj_wall);
draw_rectangle(x, y, x + global.magCollsDis, y + 64, true);

magCollsJumpRectH(x, y, x + 64, 1024 * sign(mouse_y - y), obj_wall);
draw_rectangle(x, y, x + 64, y + global.magCollsDis, true);
