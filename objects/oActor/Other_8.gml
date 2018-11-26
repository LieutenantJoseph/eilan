//clear path
path_clear_points(movementPath);

if(endPath == "ready"){
	state = "idle";

	if(actions > 0){
		oCursor.selectedActor = id;
		movementRange(map[gridX, gridY], move, actions);
	
		if(canAct){
			switch(attackType){
				case "ranged":
					rangedAttackRange(id);
					break;
				case "melee":
					meleeAttackRange(id);
					break;
			}
		}
	}
	else{
		oGame.currentActor = noone;
	}
}
else{
	state = endPath;
}