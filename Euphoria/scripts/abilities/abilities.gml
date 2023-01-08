// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function declareAbilities() {
	slot1 = throwDagger;
	slot2 = noAbility;
	slot3 = dash;
	atkSlot = noAbility;
}

function noAbility() {
}

function checkAbilities(){
	if (keySlot1) script_execute(slot1);
	if (keySlot2) script_execute(slot2);
	if (keySlot3) script_execute(slot3);
}

function dash() {
	var facing = image_xscale;
	var xx = x + (facing * dashDist);
	if (!place_meeting(x + facing * (dashDist + 32), y, objSolid)) {
		while (place_meeting(xx, y, objSolid)) {
			xx += facing;
		}
	} else {
		while (place_meeting(xx, y, objSolid)) {
			xx -= facing;
		}
	}
		x = xx;
}

function throwDagger() {
	var dagger = instance_create_layer(x, y, layer, objBullet);
	dagger.image_xscale = image_xscale;
	dagger.creator = id;
}

function throwFlash() {
	
}

function stim() {
	
}

function grapple() {
	
}

function cloak() {
	
}