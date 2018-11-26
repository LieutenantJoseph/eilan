/// @description Insert description here
// You can write your code in this editor

x = mouse_x;
y = mouse_y;

gridX = floor(x/grid_size);
gridY = floor(y/grid_size);

if(gridX < 0 || gridY < 0 || gridX >= room_width/grid_size || gridY >= room_height/grid_size){
	hoverNode = noone;
}
else{
	hoverNode = map[gridX, gridY];
}

if(mouse_check_button_pressed(mb_right)){
	if(selectedActor != noone && hoverNode.moveNode && hoverNode.occupant = noone){
		current = hoverNode;
		
		createPath(selectedActor, current)
		
		//clear node of selectedActor
		map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		
		//update selectedActor's coords
		selectedActor.gridX = gridX;
		selectedActor.gridY = gridY;
		
		//update future node values
		hoverNode.occupant = selectedActor;
		
		//begin movement state
		selectedActor.state = "begin path";
		selectedActor.endPath = "ready";
		
		//reduce actions and wipe nodes to remove color
		if(hoverNode.G > selectedActor.move){
			selectedActor.actions -= 2;
			wipeNodes();
		}
		else{
			selectedActor.actions -= 1;
			wipeNodes();
		}
		
		selectedActor = noone;
		

	}
	
	if(selectedActor != noone && hoverNode.attackNode){
		switch(selectedActor.attackType){
			case "ranged":
				selectedActor.canAct = false;
				selectedActor.actions -= 1;
				selectedActor.attackTarget = hoverNode.occupant;
				selectedActor.state = "begin attack";
				selectedActor.attackTimer = 10;
				
				selectedActor = noone;
				wipeNodes();
				break;
		
			case "melee":
				selectedActor.canAct = false;
				selectedActor.attackTarget = hoverNode.occupant;
				
				//returns distance between hoverNode and selectedActor
				tempX = abs(hoverNode.gridX - selectedActor.gridX);
				tempY = abs(hoverNode.gridY - selectedActor.gridY);
				
				//If the target is 1 tile away
				if(tempX <= 1 && tempY <= 1){
					selectedActor.actions -= 1;
					selectedActor.state = "begin attack";
					selectedActor.attackTimer = 10;
					//deselect (checks to see if more actions left later)
					selectedActor = noone;
					wipeNodes();
				}
				//otherwise, find easiest path to make attack
				else{
					//This is just an impossibly high G score, not really important that it's 100.
					tempG = 100;	
					current = noone;
					
					//cycle through neighbors list and find lowest G score after g score assignment
					for(ii = 0; ii < ds_list_size(hoverNode.neighbors); ii += 1){
						tempNode = ds_list_find_value(hoverNode.neighbors, ii)
						//if nobody is in tile and the distance is less than tempG, set the tempG to the current node's G score
						//This was, every time the loop finds a value, if it's lower than the current G score it will replace it. At the end of the loop, the lowest score will be found.
						if(tempNode.occupant == noone && tempNode.G > 0 && tempNode.G < tempG){
							tempG = tempNode.G;
							//if the tempNode has a lower G score, current = tempNode.
							current = tempNode;
						}
					}
					//Lowest G node becomes targetNode
					targetNode = current;
					
					createPath(selectedActor, targetNode);
					
					//clear node of selectedActor
					map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		
					//move selectedActor to the lowest G node
					selectedActor.gridX = targetNode.gridX;
					selectedActor.gridY = targetNode.gridY;
		
					//Update lowest G node's occupant value
					targetNode.occupant = selectedActor;
		
					//begin movement state
					selectedActor.state = "begin path";
					selectedActor.endPath = "begin attack";
					
					//mouse's tile becomes target
					selectedActor.attackTarget = hoverNode.occupant;
					
					selectedActor.actions -= 2;
					selectedActor.canAct = false;
					selectedActor = noone;
					wipeNodes();
					
				}
				
				break;
		}
	}
	
}