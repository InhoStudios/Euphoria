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
		curMoveSpeed = collideSpeed;
	} else {
		curMoveSpeed = walkSpeed;
	}
}

function enemMeleeAtkState() {
}

function enemDroneIdleState() {
	sprite_index = sprDrone;
	
	explodeTick = 0;
	
	var atNatHeight = true;
	
	for (var i = 0; i < naturalHeight; i += 8) {
		
		if (place_meeting(x, y + i, objSolid)) {
			atNatHeight = false;
			break;
		}
		
	}
	
	if (atNatHeight) {
		if (floatTick < floatTimer) {
			floatTick++;
			if (floatTick <= floatTimer / 2) 
				vsp += floatDir * floatAccel;
			else 
				vsp -= floatDir * floatAccel;
		} else {
			floatDir *= -1;
			floatTick = 0;
			vsp = 0;
		}
		if (instance_exists(objPlayer) && objPlayer.x > x - range && objPlayer.x < x + range) {
			state = enemDroneMoveState;
		}
	} else {
		vsp -= floatAccel;
		floatDir = -1;
		floatTick = 0;
	}
}

function enemDroneMoveState() {
	sprite_index = sprDroneAggro;
	explodeTick = 0;
	
	if (hsp != 0) image_xscale = sign(hsp);
	
	moveScale = lengthdir_x(1, point_direction(x, y, objPlayer.x, objPlayer.y));
	vsp = (objPlayer.y - 8 - y) * chaseAccel;
	
	if (objPlayer.x < x - range * 2 || objPlayer.x > x + range * 2) {
		moveScale = 0;
		vsp = 0;
		floatTick = 0;
		state = enemDroneIdleState;
	}
	if (instance_exists(objPlayer) && objPlayer.x > x - atkRange && objPlayer.x < x + atkRange && objPlayer.y > y - atkRange && objPlayer.y < y + atkRange) {
		state = enemDroneExplodeState;
	}
	
}

function enemDroneExplodeState() {
	
	if (image_index >= 6) image_index -= 6
	
	hsp = (objPlayer.x - x) * chaseAccel;
	vsp = (objPlayer.y - 8 - y) * chaseAccel;
	
	image_speed = 1.5;
	if (explodeTick <= explodeTimer) {
		explodeTick++;
	} else {
		instance_destroy();
	}
}