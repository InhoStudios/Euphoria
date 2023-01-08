/// @description Insert description here
// You can write your code in this editor
event_inherited();
if (place_meeting(x, y, objPlayer) && keyInteract) {
	// pop up
	with (indicator) instance_destroy();
	crowbar = true;
	instance_destroy();
}
handlePhysics();