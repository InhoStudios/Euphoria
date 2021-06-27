/// @description Insert description here
// You can write your code in this editor


// explode code
var rad = instance_create_layer(x, y, layer, objDamageBox);
rad.sprite_index = sprExplosionDmgBox;
rad.creator = id;
rad.image_xscale = image_xscale;

instance_create_layer(x, y, layer, effExplosion);