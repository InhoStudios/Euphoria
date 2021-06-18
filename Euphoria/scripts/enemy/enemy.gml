// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function enemMeleeMoveState() {
	if (instance_exists(objPlayer) && objPlayer.x > x - range && objPlayer.x < x + range) {
		moveScale = sign(objPlayer.x - x);
	}

	if (hsp != 0) image_xscale = sign(hsp);

	if (place_meeting(x, y + 1, objSolid)) {
		vsp = place_meeting(x + hsp, y, objSolid) * -jumpSpeed;
	}
	
	if (place_meeting(x, y, objEntity)) {
		moveSpeed = collideSpeed;
	} else {
		moveSpeed = walkSpeed;
	}
}

function handleEnemDamage() {
	if (place_meeting(x, y, objDamageBox) && image_blend != c_red) {
		var dmg = instance_nearest(x, y, objDamageBox);
		hp -= dmg.damage;
		
		// take damage
		moveScale = dmg.image_xscale;
		hsp = dmg.image_xscale * moveSpeed;
		image_blend = c_red;
		vsp = -jumpSpeed;
		resetTick = resetTimer;
		lastState = enemMeleeMoveState;
		
		state = enemDamageState;
	}

	if (hp <= 0) instance_destroy();
}

function enemMeleeAtkState() {
}

function enemDamageState() {
	
	if (place_meeting(x, y + 1, objSolid)) {
		resetTick--;
	}
	
	if (resetTick <= 0) {
		state = lastState;
		moveScale = 0;
		image_blend = c_white;
	}
	
}