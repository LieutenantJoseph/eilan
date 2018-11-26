if(oCursor.selectedActor == id){
	
	if(oCursor.hoverNode != noone){
		tempNode = oCursor.hoverNode
		if(tempNode.moveNode){
			current = tempNode;
			//step through every node, parent to parent, until we reach the actor's node
		
			while(current.parent != noone){
				draw_line_width_color(current.x + 32, current.y + 32, current.parent.x + 32, current.parent.y + 32, 4, c_red, c_red);
				current = current.parent;
			}
		}	
		if(tempNode.attackNode){
			switch(attackType){
				case "ranged":
					draw_line_width_color(x + 32, y + 32, tempNode.x + 32, tempNode.y + 32, 4, c_purple, c_purple);
					break;
				case "melee":
				//distance from actor to tempNode
					tempX = abs(tempNode.gridX - gridX);
					tempY = abs(tempNode.gridY - gridY);
					
					//if distance is 1 tile
					if(tempX <= 1 && tempY <= 1){
						draw_line_width_color(x + 32, y + 32, tempNode.x + 32, tempNode.y + 32, 4, c_purple, c_purple);
					}
					else{
						current = noone;
						tempG = 100;
						
						for(ii = 0; ii < ds_list_size(tempNode.neighbors); ii += 1){
							neighbor = ds_list_find_value(tempNode.neighbors, ii);
							
							if(neighbor.occupant = noone && neighbor.G > 0 && neighbor.G < tempG){
								tempG = neighbor.G;
								current = neighbor;
							}
						}
						//draws a line from the tile the actor will attack from to the target
						draw_line_width_color(tempNode.x + 32, tempNode.y + 32, current.x + 32, current.y + 32, 4, c_purple, c_purple);
						//draws movement path to tile actor is attacking from
						while(current.parent != noone){
							draw_line_width_color(current.x + 32, current.y + 32, current.parent.x + 32, current.parent.y + 32, 4, c_red, c_red);
							current = current.parent;
						}
					}
					break;
			}
		}
	}
}
	draw_self();
