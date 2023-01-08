/// @description Insert description here
// You can write your code in this editor
if (place_meeting(x, y, objPlayer)) {
	show_debug_message("transitioning");
	objPlayer.x = toX;
	objPlayer.y = toY;
	objCamera.x = toX;
	objCamera.y = toY;
	room_goto(toLevel);
}