// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getInput() {
	keyLeft = keyboard_check(ord("A"));
	keyRight = keyboard_check(ord("D"));
	keyUp = keyboard_check(ord("W"));
	keyDown = keyboard_check(ord("S"));
	keyAttack = keyboard_check_pressed(vk_space);
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
}

function handlePhysics() {
	
	if (abs(moveScale) != 0 && abs(hsp) < moveSpeed) {
		hsp += (moveScale) * accel;
	} else if (sign(moveScale) != sign(hsp) && abs(hsp) > 2 * abs(threshold)) {
		hsp -= sign(hsp) * decel + sign(hsp) * accel * place_meeting(x, y + 1, objSolid);
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
		atkSprite = sprPlayerAttackRight;
		moveSprite = sprPlayerRunLeft;
		jumpSprite = noone;
		slideSprite = noone;
		idleSprite = sprPlayerIdleRight;
	} else if (sign(hsp) == -1) {
		atkSprite = sprPlayerAttackLeft;
		moveSprite = sprPlayerRunLeft;
		jumpSprite = noone;
		slideSprite = noone;
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
				if (image_index > 5) {
					hangFrame = 8;
				}
				hangFrame = hangFrame;
				image_index = hangFrame;
			}
			break;
		case attackState:
			image_speed = actionBR;
			if (sprite_index != atkSprite) sprite_index = atkSprite;
			break;
			
	}
}

function attackState() {
	moveScale = 0;
	if (image_index >= image_number - 1) {
		sprite_index = idleSprite;
		state = moveState;
	}
}