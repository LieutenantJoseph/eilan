/// status of the attack. "hit" "miss" "crit"

status = "miss";

//default damage
damage = 0;
damageType = "piercing";

//who the attack is targeting
target = noone;

//attacker
owner = noone;

//path info
movementPath = path_add();
path_set_closed(movementPath, false);
path_set_kind(movementPath, 2);
