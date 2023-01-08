/// @description Insert description here
// You can write your code in this editor
event_inherited();
action = "pick up Crowbar"
weight = 1;

// movement constants
moveSpeed = 1;

// acceleration
accel = 0.05;
decel = 0.8;
curAccel = accel;
threshold = accel + decel;

// movement variables
curMoveSpeed = moveSpeed;
hsp = 0;
vsp = 0;
moveScale = 0;