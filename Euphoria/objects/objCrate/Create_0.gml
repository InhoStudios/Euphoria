/// @description Insert description here
// You can write your code in this editor
weight = 1;
hp = 1;
resetTick = 0;
resetTimer = 0;

// movement constants
moveSpeed = 3;

// acceleration
accel = 0.3;
decel = 0.7;
curAccel = accel;
threshold = accel + decel;

// movement variables
curMoveSpeed = moveSpeed;
hsp = 0;
vsp = 0;
moveScale = 0;

// randomize angle
image_xscale = choose(-1, 1);

deathSeq = instance_destroy;