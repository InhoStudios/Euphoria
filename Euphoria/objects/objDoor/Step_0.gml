/// @description Insert description here
// You can write your code in this editor
getInput();
if (abs(objPlayer.x - x) < range) {
	open = true;
} else {
	open = false;
}

if (open) {
	image_speed = openSpeed
	if (image_index = image_number) {
		image_speed = 0;
	}
}
if (!open) {
	image_speed = -openSpeed
	if (image_index = 0) {
		image_speed = 0;
	}
}
if (place_meeting(x, y, objPlayer) && keyInteract) {
	objPlayer.x = toX;
	objPlayer.y = toY;
	objCamera.x = toX;
	objCamera.y = toY;
	room_goto(toLevel);
}