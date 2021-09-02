draw_self();

magCollsStepH(x, y, obj_wall, 256);

draw_sprite(sprite_index, 0, x, y + global.magCollsDist);

draw_text(0, 0, global.magCollsDist);

draw_text(0, 64, place_meeting(x, y + global.magCollsDist, obj_wall));
