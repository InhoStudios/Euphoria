/// @description Insert description here
// You can write your code in this editor
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
threshold = accel + decel;

// movement variables
moveSpeed = walkSpeed;
hsp = 0;
vsp = 0;
moveScale = 0;

// atk variables
resetTick = 0;
resetTimer = 5;

// state machine
state = enemMeleeMoveState;
lastState = state;

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