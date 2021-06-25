/// @description Insert description here
// You can write your code in this editor
getInput();

// movement constants
moveSpeed = 5;
jumpSpeed = 8;
atkJolt = 3;
slideSpeed = 9;
curMoveSpeed = moveSpeed;

// acceleration
accel = 0.5;
decel = 0.1;
slideDecel = 0.02;
curAccel = accel;
threshold = accel + decel;

// movement variables
hsp = 0;
vsp = 0;
moveScale = 0;

// state machine
state = moveState;

// sprites
atkSprite = sprPlayerAttackLeft;
moveSprite = sprPlayerRunLeft;
jumpSprite = noone;
slideSprite = sprPlayerSlideLeft;
idleSprite = sprPlayerIdleLeft;

// animations
calmBR = 0.4;
actionBR = 0.5;
idleBreathRate = calmBR;
image_speed = idleBreathRate;