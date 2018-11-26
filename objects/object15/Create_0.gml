if(attackTarget.gridX == current.occupant.gridX || attackTarget.gridX + 1 == current.occupant.gridX || attackTarget.gridX - 1 == current.occupant.gridX && attackTarget.gridY + 1 == current.occupant.gridY || attackTarget.gridY - 1 == current.occupant.gridY || attackTarget.gridY == current.occupant.gridY ){
	epic = true;
}