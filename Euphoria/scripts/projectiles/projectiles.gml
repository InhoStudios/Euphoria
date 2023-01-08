// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function initProjectile() {
	damage = 0;
	flySpeed = 0;
	hsp = 0;
	vsp = 0;
	cX = x;
	cY = y;
	toX = mouse_x;
	toY = mouse_y;
}

function createProjectile(dmg, spd, tx, ty) {
	damage = dmg;
	flySpeed = spd;
	toX = tx;
	toY = ty;
	dir = point_direction(cX, cY, toX, toY)
	image_angle = dir;
}

function flyProjectile() {
	hsp = lengthdir_x(flySpeed, dir);
	vsp = lengthdir_y(flySpeed, dir);
	x += hsp;
	y += vsp;
}

function collideProjectile(objCollision) {
	if (place_meeting(x, y, objCollision)) {
		instance_destroy();
	}
}