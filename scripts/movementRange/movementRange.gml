//argument0 - origin node, node to pathfind from
//argument1 - unit's movement range
//argument2 - unit's remaining actions

//reset all node data
wipeNodes();

var open, closed;
var start, current, neighbor;
var tempG, range, costMod;

//declare relevant variables from arguments
start = argument0;
range = argument1*argument2;

//create data structures
open = ds_priority_create();
closed = ds_list_create(); 

//add starting node to the open list
ds_priority_add(open, start, start.G);

//while open queue is not empty
//repeat the following until ALL nodes have been looked at
while(ds_priority_size(open) > 0){
	//remove node with lowest G score from open
	current = ds_priority_delete_min(open);
	
	//add node to closed list
	ds_list_add(closed, current);
	
	//step through all of current's neighbors
	for(ii = 0; ii < ds_list_size(current.neighbors); ii += 1){
		//store current neighbor in neighbor variable
		neighbor = ds_list_find_value(current.neighbors, ii)
		
		//add neighbor to open list if it qualifies
		//(neighbor is passable)
		//(has no occupant)
		//(projected G score is < movement range)
		//neighbor isn't already on closed list 
		
		if(ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && neighbor.occupant = noone && neighbor.cost + current.G <= range){
			//only calculate a new g score for neighbor if it hasn't already been calculated
			
			if(ds_priority_find_priority(open, neighbor) == 0 || ds_priority_find_priority(open, neighbor) == undefined){
				costMod = 1;
				
				//give neighbor appropriate parent
				neighbor.parent = current;
				
				//if node is diag create appropriate cost mod
				if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY){
					costMod = 1.5; 
				}
				
				//calculate g score of neighbor with costMod in place
				neighbor.G = current.G + (neighbor.cost * costMod);
				
				//add neighbor to open list for checking
				ds_priority_add(open, neighbor, neighbor.G);
			}
			//else
			//if neighbor's score has already been calculated for the open list, reclac if it fits
			else{
				//figure out if the neighbor's score would be lower if found from the current node
				costMod = 1;
				
				//if node is diag create appropriate cost mod
				if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY){
					costMod = 1.5; 
				}
				tempG = current.G + (neighbor.cost * costMod);
				
				//check if G score would be lower
				if(tempG < neighbor.G){
					neighbor.parent = current;
					neighbor.G = tempG
					ds_priority_change_priority(open, neighbor, neighbor.G);
				}
				
			}
			
		}
		
	}

}

//round down all G scores for movement calculations
with(oNode){
	G = floor(G);	
}

for(ii = 0; ii < ds_list_size(closed); ii += 1){
	current = ds_list_find_value(closed, ii);
	current.moveNode = true;
	
	colorMoveNode(current, argument1, argument2);
}

//destroy closed list
ds_list_destroy(closed);