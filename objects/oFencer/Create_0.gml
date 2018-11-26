/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Guy";

class = "Human";

race = "Fencer";
//base stats
move = 2;
actions = 2;
canAct = false;

level = 1;

profMod = 2 + floor(level/5);

strMod = 1;
dexMod = 3;
conMod = 0;
intMod = 2;
wisMod = 0;
chaMod = 0;

maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;

hitBonus = profMod + strMod;
attackType = "melee";
attackRange = grid_size;
attackTarget = noone;
attackTimer = 0;

damageDice = 4;
damageBonus = strMod;
damageType = "piercing";

armorClass = 10 + dexMod;

initiative = 0;
initRoll = 0;

