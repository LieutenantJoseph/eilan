state = "idle";
party = player_party

gridX = 0;
gridY = 0;

name = "error";

class = "error";

race = "error";
//base stats
move = 2;
actions = 2;
canAct = false;

//special action
flank = true;

level = 1;

profMod = 2 + floor(level/5);

//bonuses
strMod = 0;
dexMod = 0;
conMod = 0;
intMod = 0;
wisMod = 0;
chaMod = 0;

//health
maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));
hitPoints = maxHitPoints;

//attack
hitBonus = profMod + strMod;
attackType = "melee";
attackTarget = noone;
attackTimer = 0;
//damage
damageDice = 4;
damageBonus = strMod;
damageType = "piercing";
//armor
armorClass = 10 + dexMod;

//init
initiative = 0;
initRoll = 0;

//pathing variables
movementPath = path_add();
path_set_kind(movementPath, 2);
path_set_closed(movementPath, false);

endPath = "idle";

moveSpeed = 8;

shake = 0;
shakeMag = 0;
