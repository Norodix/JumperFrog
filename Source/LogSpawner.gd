extends Node2D

const STEP_SIZE = 32
const MAXLENGTH = 6
const MAXGAP = 5
const SCREENWIDTH = 640
var yPos =360
var velocity = -100
var LogResource = preload("res://Log.tscn")

var logs = []
# Called when the node enters the scene tree for the first time.
func _ready():
	#yPos = self.position.y
	randomize()
	#create logs


	var index = -MAXLENGTH*STEP_SIZE
	var i = 0
	while index < SCREENWIDTH:
		#pick a length
		var l = randi() % (MAXLENGTH-1) + 2
		#create a log at index position with l length
		logs.append(LogResource.instance())
		logs[i].length = l
		logs[i].position.x = index
		logs[i].position.y = yPos
		self.add_child(logs[i])
		index += STEP_SIZE*l
		#pick a gap
		var gap = randi() % (MAXGAP*STEP_SIZE)
		index += gap
		i+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#delete out of bound logs
	for Log in logs:
		if (Log.position.x > SCREENWIDTH && velocity > 0 ||
		Log.position.x < -MAXLENGTH*STEP_SIZE && velocity < 0):
			logs.erase(Log)
			Log.queue_free()
			
			
	#spawn a new one at 0 or end, based on velocity
	#find last log point and first one
	var minX = SCREENWIDTH
	var maxX = -MAXLENGTH*STEP_SIZE
	for Log in logs:
		minX = min(minX, Log.position.x)
		maxX = max(maxX, Log.position.x + Log.length*STEP_SIZE)
	
	#when a new one needs to be spawned off-screen
	if (minX > 0 && velocity > 0) || (maxX < SCREENWIDTH && velocity < 0):
		var gap = randi() % (MAXGAP*STEP_SIZE)
		var l = randi() % (MAXLENGTH-1) + 2
		logs.append(LogResource.instance())
		logs[-1].length = l
		logs[-1].position.y = yPos
		
		if (velocity > 0):
			logs[-1].position.x = minX - gap - l*STEP_SIZE
			pass
		else:
			logs[-1].position.x = maxX + gap
			pass
		self.add_child(logs[-1])

		
	for Log in logs:
		Log.position.x += velocity*delta
	

