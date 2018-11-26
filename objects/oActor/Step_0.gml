switch(state){
	case "begin path":
		//begin moving along path
		path_start(movementPath, moveSpeed, 0, true);
		state = "moving";
		break;
		
	case "begin attack":
		//put animations here
		attackTimer -= 1;
		if(attackTimer <= 0){
			state = "attack";
		}
		
		break;
		
	case "attack":
		//set advantage and disadvantage and flank to false
		flank = false;
		advantage = false;
		disadvantage = false;
		
		//get node of target being attack
		tempNode = map[attackTarget.gridX, attackTarget.gridY];
		
		//loop through neighbors to check for an ally next to target
		for(ii = 0; ii < ds_list_size(tempNode.neighbors); ii += 1){
			current = ds_list_find_value(tempNode.neighbors, ii);
			
			if(current.occupant != noone && current.occupant != id){
				//if current.occupant is one tile away from attackTarget (very complex and unnecessary, fix later)
				if(attackTarget.gridX == current.occupant.gridX || attackTarget.gridX + 1 == current.occupant.gridX || attackTarget.gridX - 1 == current.occupant.gridX && attackTarget.gridY + 1 == current.occupant.gridY || attackTarget.gridY - 1 == current.occupant.gridY || attackTarget.gridY == current.occupant.gridY){
				//if the neighbor node's occupant is NOT the same as the TARGET's party, they are flanked and the attacker is given advantage
					if(current.occupant.party != attackTarget.party){
						advantage = true;
						flank = true;
					}
				}
			}
		}
		
		//make attack roll
		//check if advantage or disadvantage
		if(advantage || disadvantage){
			//if attack has advantage
			if(advantage){
				tempAttackRoll = irandom_range(1, 20);
				//roll again
				reRoll = irandom_range(1, 20);
				if(reRoll > tempAttackRoll){
					attackRoll = reRoll;
				}
				else{
					attackRoll = tempAttackRoll;
				}
			}
			//if attacker has disadvantage
			else{
				tempAttackRoll = irandom_range(1, 20);
				//roll again
				reRoll = irandom_range(1, 20);
				if(reRoll > tempAttackRoll){
					attackRoll = reRoll;
				}
				else{
					attackRoll = tempAttackRoll;
				}
			}
		}
		//if normal roll
		else{
			attackRoll = irandom_range(1, 20);
		}
				
		//determine outcome of roll
		if(attackRoll == 20){
			attackStatus = "crit";
		}
		else{
			if(attackRoll + hitBonus >= attackTarget.armorClass){
				attackStatus = "hit";
			}
			else{
				attackStatus = "miss";
			}
		}
				
		tempDamage = 0;
				
		//make damage roll
		if(attackStatus != "miss"){
			//roll damage dice
			tempDamage = irandom_range(1, damageDice);
			//if critical hit, double damage
			if(attackStatus == "crit"){
				tempDamage *= 2;
			}
			//add damage modifier
			tempDamage += damageBonus;
		}
		switch(attackType){
			case "ranged":
				
				attackDir = point_direction(x + 32, y + 32, attackTarget.x + 16, attackTarget.y + 16);
				beginX = x + 32 + lengthdir_x(30, attackDir);
				beginY = y + 32 + lengthdir_y(30, attackDir);
				
				with(instance_create_depth(beginX, beginY, -1, oArrow)){
					target = other.attackTarget;
					status = other.attackStatus;
					damage = other.tempDamage;
					damageType = other.damageType;
					
					path_add_point(movementPath, other.beginX, other.beginY, 100);
					
					if(status != "miss"){
						path_add_point(movementPath, target.x + 32, target.y + 32, 100);
					}
					else{
						path_add_point(movementPath, (target.x + irandom_range(30, 50) * choose(-1, 1)), target.y + (irandom_range(30, 50) * choose(-1, 1)), 100);
					} 
					
					path_start(movementPath, speed, true, true);
				}
				
				state = "end attack";
				
				attackTimer = 30;
				
				break;
				
			case "melee":
				if(attackStatus != "miss"){
					for(ii = 0; ii < 6; ii += 1){
						with(instance_create_depth(attackTarget.x + 32, attackTarget.y + 32, -2, oDParticle)){
							direction = irandom(360);
							speed = choose(2, 4);
							scale = choose(2, 3);
							
							image_speed = 0.5;
				
						}
					}
					attackTarget.hitPoints -= tempDamage;
					
					with(instance_create_depth(attackTarget.x + 56, attackTarget.y + 4, -3, oDamageText)){
						text = "-" + string(other.tempDamage);
						ground = y;
						
						if(other.attackStatus == "crit"){
							font = fCrit;
						}
						
					}
					if(attackStatus == "crit"){
						with(instance_create_depth(attackTarget.x + 56, attackTarget.y + string_height(def_text), -3, oDamageText)){
							text = "Critical!";
							ground = y;
						
						}
					}
					if(flank){
						with(instance_create_depth(attackTarget.x + 56, attackTarget.y + string_height(def_text), -3, oDamageText)){
							text = "Flanked!";
							ground = y;
						
						}
					}
					
					
				}	
				else{
					with(instance_create_depth(attackTarget.x + 56, attackTarget.y + 4, -2, oDamageText)){
						text = "Miss!"
						ground = y;
					}
				}
				
				state = "end attack";
				
				attackTimer = 30;
				
				break;
		}
		break;
	
	case "end attack":
		attackTimer -= 1;
		if(attackTimer <= 0){
			if(actions > 0){
				oCursor.selectedActor = id;
				movementRange(map[gridX, gridY], move, actions);
			}
			else{
				oGame.currentActor = noone;
			}
			
			state = "idle";
			
		}
		break;
}


		
