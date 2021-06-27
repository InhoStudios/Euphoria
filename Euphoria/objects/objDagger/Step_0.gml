/// @description Insert description here
// You can write your code in this editor
if (!place_meeting(x, y, objSolid)) {
	image_angle -= image_xscale * 15;
	x += image_xscale * flySpeed;
} else {
	if (!stuck) {
		switch (image_xscale) {
			case -1:
				image_angle = irandom_range(30, 150);
				break;
			case 1:
				image_angle = irandom_range(210, 330);
				break;
		}
	}
	stuck = true;
}