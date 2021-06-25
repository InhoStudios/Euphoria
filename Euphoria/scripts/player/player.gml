// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getInput() {
	keyLeft = keyboard_check(ord("A"));
	keyRight = keyboard_check(ord("D"));
	keyUp = keyboard_check(ord("W"));
	keyDown = keyboard_check(ord("S"));
	keyAttack = keyboard_check_pressed(vk_space);
	keySlide = keyboard_check(vk_control);
}

function moveState() {
	moveScale = keyRight - keyLeft;

	if (hsp != 0) image_xscale = sign(hsp);

	if (place_meeting(x, y + 1, objSolid)) {
		vsp = keyUp * -jumpSpeed;
	}
	
	if (keyAttack) {
		moveScale = keyRight - keyLeft;
		if (moveScale == 0) moveScale = image_xscale;
		hsp = moveScale * atkJolt;
		image_index = 0;
		var dmg = instance_create_layer(x, y, layer, objDamageBox);
		dmg.image_xscale = moveScale;
		state = attackState;
	}
	
	if (keySlide && abs(hsp) >= moveSpeed && place_meeting(x, y + 1, objSolid)) {
		moveScale = keyRight - keyLeft;
		if (moveScale == 0) moveScale = image_xscale;
		curAccel = slideDecel;
		hsp = moveScale * slideSpeed;
		state = slideState;
	}
		
		
}

function slideState() {
	moveScale = 0;
	if (place_meeting(x + hsp, y - 1, objSolid) && abs(hsp) <= moveSpeed) {
		var diff = moveSpeed - abs(hsp);
		if (diff >= moveSpeed / 3) {
			curAccel = accel;
			curMoveSpeed = moveSpeed;
			hsp = 0;
			state = moveState;
		}
		if (place_meeting(x, y - 30, objSolid)) {
			moveScale = image_xscale;
			hsp = moveScale * (moveSpeed - diff);
		}
	}
	
	if (!keySlide && !place_meeting(x, y - 30, objSolid)) {
		curAccel = accel;
		curMoveSpeed = moveSpeed;
		hsp = image_xscale * curMoveSpeed;
		state = moveState;
	}
}

function attackState() {
	moveScale = 0;
	if (image_index >= image_number - 1) {
		sprite_index = idleSprite;
		state = moveState;
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
		vsp += grav;
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

function handleSprites() {
	if (sign(hsp) == 1) {
		atkSprite = sprPlayerAttackLeft;
		moveSprite = sprPlayerRunLeft;
		jumpSprite = noone;
		slideSprite = sprPlayerSlideLeft;
		idleSprite = sprPlayerIdleLeft;
	} else if (sign(hsp) == -1) {
		atkSprite = sprPlayerAttackLeft;
		moveSprite = sprPlayerRunLeft;
		jumpSprite = noone;
		slideSprite = sprPlayerSlideLeft;
		idleSprite = sprPlayerIdleLeft;
	}
	switch(state) {
		case moveState:
			if (hsp == 0) {
				image_speed = calmBR;
				if (sprite_index != idleSprite) {
					image_index = 0;
					sprite_index = idleSprite;
				}
			} else {
				image_speed = actionBR;
				if (sprite_index != moveSprite) {
					image_index = 0;
					sprite_index = moveSprite;
				}
			}
			if (!place_meeting(x, y + 1, objSolid)) {
				var hangFrame = 3;
				if (image_index > 4) {
					hangFrame = 8;
				}
				if (image_index >= hangFrame - 1) {
					image_index = hangFrame;
				}
			}
			break;
		case attackState:
			image_speed = actionBR;
			if (sprite_index != atkSprite) sprite_index = atkSprite;
			break;
		case slideState:
			if (sprite_index != slideSprite) sprite_index = slideSprite;
			break;
			
	}
}