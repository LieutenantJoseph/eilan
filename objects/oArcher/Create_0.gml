/// @description Insert description here
// You can write your code in this editor
event_inherited();

name = "Soveliss"

class = "Human";

race = "Archer";
//base stats
move = 2;
actions = 2;
canAct = false;

level = 1;

profMod = 2 + floor(level/5);

strMod = 2;
dexMod = 3;
conMod = 0;
intMod = 1;
wisMod = 0;
chaMod = 0;

maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;

hitBonus = profMod + strMod;
attackType = "ranged";
attackRange = 6 * grid_size;
attackTarget = noone;
attackTimer = 0;

damageDice = 4;
damageBonus = dexMod;
damageType = "piercing";

armorClass = 10 + dexMod;

initiative = 0;
initRoll = 0;

