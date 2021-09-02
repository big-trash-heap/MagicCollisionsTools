draw_self();

if (magCollsStepH(x, y, obj_wall, -256, function(){return true}))
	draw_set_color(c_yellow);
else
	draw_set_color(c_lime);

draw_sprite_ext(sprite_index, 0, x, y + global.magCollsDist, 1, 1, 0, c_red, 1);

draw_text(0, 0, global.magCollsDist);

draw_text(0, 64, place_meeting(x, y + global.magCollsDist, obj_wall));
