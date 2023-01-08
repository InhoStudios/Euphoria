// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getInput() {
	keyLeft = keyboard_check(ord("A"));
	keyRight = keyboard_check(ord("D"));
	keyUp = keyboard_check(ord("W")) | keyboard_check(vk_space);
	keyDown = keyboard_check(ord("S"));
	keySlide = keyboard_check(vk_control);
	keySprint = keyboard_check(vk_shift);
	keyInteract = keyboard_check_pressed(ord("E"));
	
	keySlot1 = keyboard_check_pressed(ord("Q"));
	mouseADS = mouse_check_button(mb_right);
	mouseShoot = mouse_check_button_pressed(mb_left);
}

function moveState() {
	
	if (keySprint) {
		curMoveSpeed = moveSpeed;
	} else {
		if (abs(hsp) < moveSpeed) {
			hsp = moveScale * walkSpeed;
			curMoveSpeed = walkSpeed;
		}
	}
	
	moveScale = keyRight - keyLeft;
	curAccel = accel;
	if (place_meeting(x, y + 1, objSolid)) {
		vsp = keyUp * -jumpSpeed;
	}
	
	if(hasGun){
		if (mouseADS) {
			moveScale = sign(mouse_x - x);
			image_xscale = moveScale;
			image_index = 0;
			state = adsState;
		}
	
		if (mouseShoot) {
			moveScale = sign(mouse_x - x);
			image_xscale = moveScale;
			image_index = 0;
			state = attackState;
		}
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
	if (place_meeting(x + hsp, y - 30, objSolid) && abs(hsp) <= moveSpeed) {
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
	if(image_index = 1) {
		var bullet = instance_create_layer(x, y, layer, objBullet);
		bullet.image_xscale = image_xscale;
		bullet.creator = id;
	}
	if (mouseShoot) {
		image_index = 0;
	}
	if (image_index >= image_number - 1) {
		sprite_index = idleSprite;
		if (mouseADS) state = adsState;
		else state = moveState;
	}
}

function adsState() {
	moveScale = 0;
	if (sign(mouse_x - x) != image_xscale) {
		moveScale = sign(mouse_x - x);
		image_xscale = moveScale;
	}
	if (mouseShoot) {
		moveScale = sign(mouse_x - x);
		image_xscale = moveScale;
		image_index = 0;
		state = attackState;
	}
	if (!mouseADS) state = moveState;
}

function handleSprites() {

	if (moveScale != 0) image_xscale = moveScale;

	if (moveScale == 1) {
		atkSprite = sprPlayerAttackLeft;
		moveSprite = sprPlayerRunLeft;
		walkSprite = sprPlayerWalkLeft;
		jumpSprite = noone;
		slideSprite = sprPlayerSlideLeft;
		idleSprite = sprPlayerIdleLeft;
	} else if (moveScale == -1) {
		atkSprite = sprPlayerAttackLeft;
		moveSprite = sprPlayerRunLeft;
		walkSprite = sprPlayerWalkLeft;
		jumpSprite = noone;
		slideSprite = sprPlayerSlideLeft;
		idleSprite = sprPlayerIdleLeft;
	}
	switch(state) {
		case moveState:
			if (hsp == 0) {
				image_speed = (hsp/moveSpeed) * calmBR;
				if (sprite_index != idleSprite) {
					image_index = 0;
					sprite_index = idleSprite;
				}
			} else {
				image_speed = actionBR;
				if (abs(hsp) <= walkSpeed) {
					if (sprite_index != walkSprite) {
						if (sprite_index != moveSprite) image_index = 0;
						sprite_index = walkSprite;
					}
				} else {
					if (sprite_index != moveSprite) {
						if (sprite_index != walkSprite) image_index = 0;
						sprite_index = moveSprite;
					}
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
		case adsState:
			image_speed = 0;
			if (sprite_index != atkSprite) sprite_index = atkSprite;
			break;
		case slideState:
			if (sprite_index != slideSprite) sprite_index = slideSprite;
			break;
			
	}
}

function drawADS() {
	if (mouseADS && hasGun) {
		var dir = point_direction(x + image_xscale * 14, y, mouse_x, mouse_y)
		var dist = 180;
		losX = x + lengthdir_x(dist, dir)
		losY = y + lengthdir_y(dist, dir)
		draw_line(x + image_xscale * 14, y, losX, losY)
	}
}