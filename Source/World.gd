extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#create logs
	var LogResource = preload("res://Log.tscn")
	var logs = []
	for i in 10:
		logs.append(LogResource.instance())
		rand_seed(OS.get_unix_time())
		logs[i].length = (randi() % 4) + 2
		logs[i].position = Vector2(randi()%640, randi()%420)
		self.add_child(logs[i])
		print(logs[i].length)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
