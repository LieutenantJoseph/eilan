switch(state){
	
	case "initializing":
		with(oNode){		
			if(instance_position(x + 32, y + 32, oTerrain)){
				tempTerrain = instance_position(x + 32, y + 32, oTerrain);
				switch(tempTerrain.type){

					case "plains":
						instance_change(oPlains, true);
						type = "plains";
						//sprite_index = sPlains;
						break;
			
					case "water":
						instance_change(oWater, true);
						type = "water";
						sprite_index = sWater;
						passable = false;
						break;
			
					case "shrub":
						instance_change(oShrub, true);
						type = "shrub";
						sprite_index = sShrub;
						cost = 2;
						break;
				}
				with(tempTerrain){
					instance_destroy();
				}
			
			
				if(instance_position(x + 32, y + 32, oActor)){
					occupant = instance_position(x + 32, y+ 32, oActor);
					occupant.gridX = gridX;
					occupant.gridY = gridY;
				}
			
			}
			
		}
		state = "roll init";
		break;

		case "roll init":
			//create init queue
			tempInit = ds_priority_create();
			//roll init for each actor in queue
			with(oActor){
				initRoll = irandom_range(1, 20) + initiative;
			
				ds_priority_add(other.tempInit, id, initRoll);
			}
			
			while(ds_priority_size(tempInit > 0)){
				ds_list_add(turnOrder, ds_priority_delete_max(tempInit));
			}
			
			turnMax = ds_list_size(turnOrder);
			
			ds_priority_destroy(tempInit);
			state = "ready";
			break;
			
		case "ready":
			if(currentActor == noone){
				turnCounter += 1;
				
				if(turnCounter >= turnMax){
					turnCounter = 0;
					roundCounter += 1;
				}
				
				currentActor = ds_list_find_value(turnOrder, turnCounter);
				
				currentActor.actions = 2;
				currentActor.canAct = true;
				//only pass off cursor control if actor is player_party
				//otherwise set flash to true and set alarm
				if(currentActor.party == player_party){
					oCursor.selectedActor = currentActor;
					movementRange(map[currentActor.gridX, currentActor.gridY], currentActor.move, currentActor.actions);
					
					switch(currentActor.attackType){
						case "ranged":
							rangedAttackRange(currentActor);
							break;
						case "melee":
							meleeAttackRange(currentActor);
							break;
					}
				}
				else{
					currentActor.flash = true;
					currentActor.alarm[0] = 30;
				}
				
				
				
			}
}