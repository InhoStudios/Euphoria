// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handleCollisionPush(){
	if (place_meeting(x - moveSpeed, y, objPlayer) || place_meeting(x + moveSpeed, y, objPlayer)) {
		moveScale = sign(x - objPlayer.x);
	} else {
		moveScale = 0;
	}
}