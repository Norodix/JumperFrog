extends Node2D

var length = 2 #default length


# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap = $TileMap
	var tiles = tilemap.get_used_cells()
	#for tile in tiles:
	#	print($TileMap.get_cell(tile.x, tile.y))
	for i in length:
		tilemap.set_cell(i, 0, 0)
	tilemap.update_bitmask_region()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
