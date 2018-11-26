state = "initializing";

draw_set_font(fDefault);

randomize();

turnOrder = ds_list_create();
turnCounter = -1;
turnMax = 0;
currentActor = noone;
roundCounter = 0;

globalvar map;

mapWidth = room_width/grid_size;
mapHeight = room_height/grid_size;

//create nodes
for (xx = 0; xx < mapWidth; xx += 1){
	for (yy = 0; yy < mapHeight; yy += 1){
		map[xx, yy] = instance_create_depth(xx * grid_size, yy * grid_size, 1, oNode);
		map[xx, yy].gridX = xx;
		map[xx, yy].gridY = yy;
	}
}
//populate neighbor lists
for(xx = 0; xx < mapWidth; xx += 1){
	for(yy = 0; yy < mapHeight; yy += 1){
		
		node = map[xx, yy];
		
		//add left neighbor
		if(xx > 0){
			ds_list_add(node.neighbors, map[xx -1, yy]);
		}
		
		//add right neightbor
		if(xx < mapWidth - 1){
			ds_list_add(node.neighbors, map[xx + 1, yy]);
		}
		
		//add top neigbor
		if(yy > 0){
			ds_list_add(node.neighbors, map[xx, yy - 1]);
		}
		
		//add bottom neighbor
		if(yy < mapHeight - 1){
			ds_list_add(node.neighbors, map[xx, yy + 1]);
		}
		
		//top left neighbor
		if(xx > 0 && yy > 0){
			ds_list_add(node.neighbors, map[xx - 1, yy - 1])
		}
		
		//top right neighbor
		if(xx < mapWidth - 1 && yy > 0){
			ds_list_add(node.neighbors, map[xx + 1, yy - 1])
		}
		
		//bottom left neighbor
		if(xx > 0 && yy < mapHeight - 1){
			ds_list_add(node.neighbors, map[xx - 1, yy + 1]);
		}
		
		//bottom right neighbor
		if(xx < mapWidth - 1 && yy < mapHeight - 1){
			ds_list_add(node.neighbors, map[xx + 1, yy + 1]);
		}
		
	}
}

instance_create_depth(x, y, -1, oCursor);
