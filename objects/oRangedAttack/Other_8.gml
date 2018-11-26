if(status != "miss"){
	target.hitPoints -= damage;
	for(ii = 0; ii < 6; ii += 1){
		with(instance_create_depth(target.x + 32, target.y + 32, -1, oDParticle)){
			direction = irandom(360);
			speed = irandom_range(2, 4);
			scale = choose(2, 3);
			
			image_speed = .5;
			
			if(other.status == "crit"){
				color = c_yellow;
			}
		}
	}
	
	with(instance_create_depth(target.x + 56, target.y + 4, -2, oDamageText)){
		text = "-" + string(other.damage);
		
		ground = y;
		if(other.status == "crit"){
			font = fCrit;
		}
	}
	
	
}
else{
	with(instance_create_depth(target.x + 28, target.y + 2, -2, oDamageText)){
		text = "Miss!";
		ground = y;
	}
}

instance_destroy();
