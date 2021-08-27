extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var LogSpawnerResource = preload("res://LogSpawner.tscn")
var spawners = []

func createSpawner(y, velocity):
	spawners.append(LogSpawnerResource.instance())
	spawners[-1].yPos = y
	spawners[-1].velocity = velocity
	self.add_child(spawners[-1])
	
# Called when the node enters the scene tree for the first time.
func _ready():
	createSpawner(368, 100)
	createSpawner(368-(32+16), -100)
	createSpawner(368-(32+16)*2, 100)
	createSpawner(368-(32+16)*3, -100)
	createSpawner(368-(32+16)*4, 100)
	createSpawner(368-(32+16)*5, -100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#create logspawners around visible area
	pass
