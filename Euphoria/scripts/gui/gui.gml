// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function drawGUIText(message){
	draw_set_halign(fa_center);
	draw_text(window_get_width() / 2, 7 * window_get_height()/8, message);
	draw_set_halign(fa_left);
}