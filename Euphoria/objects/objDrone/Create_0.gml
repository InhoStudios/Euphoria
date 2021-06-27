hp = 3;

// movement constants
walkSpeed = 3;
range = 128;
jumpSpeed = 0.5;
collideSpeed = 2;

weight = 0;

// hovering
floatTick = 0;
floatTimer = room_speed;
floatDir = 1;
floatAccel = 0.01;
naturalHeight = 56;

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
state = enemDroneIdleState;
lastState = state;
resetState = enemDroneIdleState;

resetTick = 0;
resetTimer = 5;

// sprites
atkSprite = sprDrone;
moveSprite = sprDrone;
jumpSprite = sprDrone;
slideSprite = sprDrone;
idleSprite = sprDrone;

// animations
image_speed = 0.5;

deathSeq = instance_destroy;