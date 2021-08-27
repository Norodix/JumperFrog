extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SCREEN_HEIGHT = 480
var LogSpawnerResource = preload("res://LogSpawner.tscn")
var spawners = []
var globalY = 0

func createSpawner(y, velocity):
	spawners.append(LogSpawnerResource.instance())
	spawners[-1].yPos = y
	spawners[-1].velocity = velocity
	self.add_child(spawners[-1])

# Called when the node enters the scene tree for the first time.
func _ready():
	createSpawner(368, 100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#create logspawners around visible area
	globalY = -self.get_canvas_transform().origin.y
	
	#get min Y coord spawner
	var minY = SCREEN_HEIGHT
	var maxY = -INF
	var minSpawner
	
	for spawner in spawners:
		if (spawner.yPos < minY):
			minSpawner = spawner
			minY=spawner.yPos
		maxY = max(maxY, spawner.position.y)
	
	#if not outside top of frame, add a new one with opposing velocity above it
	if (globalY < minY):
		createSpawner(minY - 48, - minSpawner.velocity)
	
	#TODO delete spawners outside the frame
	pass
