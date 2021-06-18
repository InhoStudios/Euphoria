// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cameraCreate() {
	cam = view_camera[0];
	camW = camera_get_view_width(cam);
	camH = camera_get_view_height(cam);
	
	target = objPlayer;
	panSpeed = 0.2;
}

function cameraFollow() {
	tx = target.x + (target.image_xscale * camera_get_view_width(cam) / 8)
	ty = target.y - (camera_get_view_height(cam) / 6);
	
	x += (tx - x) * panSpeed;
	y += (ty - y) * panSpeed;
	xx = x - camera_get_view_width(cam) / 2;
	yy = y - camera_get_view_height(cam) / 2;
	xx = clamp(xx, 0, room_width - camera_get_view_width(cam));
	yy = clamp(yy, 0, room_height - camera_get_view_height(cam));
	camera_set_view_pos(cam, xx, yy);
}