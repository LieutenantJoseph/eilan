//arg0 = actor performing range check

actor = argument0;

with(oActor){
	tempActor = other.actor; 
	if(party != tempActor.party){
		//check if in range
		if(point_distance(x + 16, y + 16, tempActor.x + 16, tempActor.y + 16) <= tempActor.attackRange){
			//Change oWater to oWall when it gets added in
			if(!collision_line(x + 16, y + 16, tempActor.x + 16, tempActor.y + 16, oWater, false, false)){
				map[gridX, gridY].attackNode = true;
				map[gridX, gridY].color = c_red;
			}
		}
	}
}
