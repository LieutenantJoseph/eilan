/// @description Insert description here
// You can write your code in this editor
if(hoverNode != noone){
	draw_sprite(sSelected, -1, gridX * grid_size, gridY * grid_size);
}

draw_self();

if(hoverNode != noone){
	tempText = string(gridX) + "/" + string(gridY) + " = "
	if(hoverNode.occupant != noone){
		tempText += hoverNode.occupant.name;
	}else{
		tempText += "noone";
	}
	
	draw_set_color(c_black);
	
	draw_rectangle(0, 0, string_width(tempText), string_height(tempText), false);
	draw_set_color(c_lime);
	
	draw_text(0, 0, tempText);
	draw_set_color(c_white);

	tempText = hoverNode.type;
	
	if(hoverNode.passable){
		tempText += " passable = true" + " cost = " + string(hoverNode.cost);
	}
	
	draw_set_color(c_black);
	draw_rectangle(0, 20, string_width(tempText), 20 + string_height(tempText), false);
	
	draw_set_color(c_green);
	draw_text(0, 20, tempText);

}

if(selectedActor != noone){
	tempText = selectedActor.name + " " + selectedActor.race + " " + selectedActor.class + " " + string(selectedActor.hitPoints) + "/" + string(selectedActor.maxHitPoints);
	
	draw_set_color(c_black);
	draw_rectangle(0, room_height, string_width(tempText), room_height - string_height(tempText), false);
	
	draw_set_color(c_green);
	draw_text(0, room_height - string_height(tempText), tempText);
	
	draw_set_color(c_white);
}


