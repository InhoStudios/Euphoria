/// @description Insert description here
// You can write your code in this editor
image_speed = 0;
image_index = 1;
if (!place_meeting(x - 2, y, objMarketSidewalk)) {
	image_index = 0;
} else if (!place_meeting(x + 2, y, objMarketSidewalk)) {
	image_index = 2;
}