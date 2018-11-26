///createPath(actor, destination)


selectedActor = argument0;
current = argument1;

//create priority queue
path = ds_priority_create();
		
//add current node to queue
ds_priority_add(path, current, current.G);
		
//step through each node, parent to parent, until done
while(current.parent != noone){
	//add parent node to queue. Priority equal to parent g score
	ds_priority_add(path, current.parent, current.parent.G);
			
	//set current equal to current's parent, ready to start over
	current = current.parent;
}
		
do{
	//delete lowest priority node (closest to actor's) store id in current
	current = ds_priority_delete_min(path);
			
	//add current node's sprite coordinates to selectedActor's path
	path_add_point(selectedActor.movementPath, current.x, current.y, 100);
}until(ds_priority_empty(path));
		
//kill queue
ds_priority_destroy(path);