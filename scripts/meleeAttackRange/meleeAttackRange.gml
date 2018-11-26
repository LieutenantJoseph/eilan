//argument 0 - actor we're doing range calculation for

actor = argument0;

actions = actor.actions;

range = actor.move;



with(oActor){
	if(party != other.actor.party){
		tempX = abs(gridX - other.actor.gridX);
		tempY = abs(gridY - other.actor.gridY);
		
		//if next to target
		if(tempX <= 1 && tempY <= 1){
			map[gridX, gridY].attackNode = true;
			map[gridX, gridY].color = c_red;
		}
		//otherwise
		else{
			//if our actor's actions are > 1
			if(other.actions > 1){
				//node that this actor is standing on
				node = map[gridX, gridY];
				
				for(ii = 0; ii < ds_list_size(node.neighbors); ii += 1){
					neighbor = ds_list_find_value(node.neighbors, ii)
					
					if(neighbor.G > 0 && neighbor.G <= other.range){
						map[gridX, gridY].attackNode = true;
						map[gridX, gridY].color = c_red;
					}
				}
			}
		}
		
	}
}