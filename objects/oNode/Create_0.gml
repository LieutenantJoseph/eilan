//create data structure storing neighbors
neighbors = ds_list_create();

color = c_white;

occupant = noone;
passable = true;

gridX = 0;
gridY = 0;

type = "node";

//pathfinding
parent = noone;
G = 0;
moveNode = false;
attackNode = false;
cost = 1;

