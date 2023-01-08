/// @description Insert description here
// You can write your code in this editor
getInput();
indicator.x = x;
indicator.y = y;
if (place_meeting(x, y, objPlayer) && keyInteract) {
	// pop up
	with (indicator) instance_destroy();
}