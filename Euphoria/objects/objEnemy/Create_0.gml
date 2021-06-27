/// @description Insert description here
// You can write your code in this editor
event_inherited();

hp = 3;
// movement constants
walkSpeed = 3;
collideSpeed = 2;
jumpSpeed = 8;
atkJolt = 7;
range = 64;

// acceleration
accel = 0.5;
decel = 0.1;
curAccel = accel;
threshold = accel + decel;

// movement variables
curMoveSpeed = walkSpeed;
hsp = 0;
vsp = 0;
moveScale = 0;

// state machine
state = enemMeleeMoveState;
resetState = enemMeleeMoveState;

// sprites
atkSprite = sprEnemy;
moveSprite = sprEnemy;
jumpSprite = sprEnemy;
slideSprite = sprEnemy;
idleSprite = sprEnemy;

// animations
calmBR = 0.2;
actionBR = 0.5;
idleBreathRate = calmBR;
image_speed = idleBreathRate;

deathSeq = instance_destroy;
