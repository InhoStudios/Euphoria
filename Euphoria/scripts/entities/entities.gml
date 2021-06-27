// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function handleDamage(){
	if (place_meeting(x, y, objDamageBox) && image_blend != c_red) {
		var dmg = instance_nearest(x, y, objDamageBox);
		
		if (id != dmg.creator) {
		
			hp -= dmg.damage;
		
			// take damage
			moveScale = dmg.image_xscale;
			hsp = dmg.image_xscale * curMoveSpeed;
			image_blend = c_red;
			vsp = -jumpSpeed;
			resetTick = resetTimer;
		
			with (dmg) instance_destroy();
		
			state = damageState;
		}
	}
	if (hp <= 0) script_execute(deathSeq);
}

function damageState() {
	
	if (place_meeting(x, y + 1, objSolid)) {
		resetTick--;
	}
	
	if (resetTick <= 0) {
		state = resetState;
		moveScale = 0;
		image_blend = c_white;
	}
	
}

function handlePhysics() {
	
	if (abs(moveScale) != 0 && abs(hsp) < curMoveSpeed) {
		hsp += (moveScale) * curAccel;
	} else if (sign(moveScale) != sign(hsp) && abs(hsp) > 2 * abs(threshold)) {
		hsp -= sign(hsp) * decel + sign(hsp) * curAccel * place_meeting(x, y + 1, objSolid);
	} else if (abs(hsp) <= 2 * abs(threshold)) {
		hsp = 0;
	}
	
	if (vsp < 12) {
		vsp += weight * grav;
	}
	
	// horizontal collision
	if (place_meeting(x + hsp, y, objSolid)) {
		while (!place_meeting(x + sign(hsp), y, objSolid)) {
			x += sign(hsp);
		}
		hsp = 0;
	}
	x += hsp;

	if (place_meeting(x, y + vsp, objSolid)) {
		while (!place_meeting(x, y + sign(vsp), objSolid)) {
			y += sign(vsp);
		}
		vsp = 0;
	}
	y += vsp;
}