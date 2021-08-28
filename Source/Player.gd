extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const STEP_SIZE = 32
const JUMP_SIZE = 32 + 16
var velocity = Vector2()
var jumping = false
var jumpSpeed = 0
var jumpDir

var screen_x = 0
var currentLog = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_x = get_viewport().get_visible_rect().size.x
	jumpSpeed = JUMP_SIZE / $JumpTimer.wait_time
	pass # Replace with function body.

func is_jumping():
	return !$JumpTimer.is_stopped()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!is_jumping()):
		if Input.is_action_just_pressed("ui_up") && !jumping:
			$JumpTimer.start()
			jumpDir = 1
			$AnimationPlayer.play("Jump")
			pass
		if Input.is_action_just_pressed("ui_down") && !jumping:
			$JumpTimer.start()
			jumpDir = -1
			#$AnimationPlayer.play("Jump")
			pass


	
func clip(minVal, maxVal, value):
	var retVal = value
	retVal = max(minVal, retVal)
	retVal = min(maxVal, retVal)
	return retVal
	
func snap(resolution, value):
	return round(float(value) / float(resolution)) * resolution

func _physics_process(delta):
	velocity = Vector2(0, 0)
	if(!is_jumping()):
		#TODO snap to log's grid on X axis
		var bodies = get_overlapping_bodies()
		if (bodies.size() < 1):
			currentLog = 0
		else:
			#Snap if on log
			currentLog = bodies[0].get_owner()
			#get X relative to log
			var xRel = self.position.x - currentLog.position.x
			# align center to center
			var offset = - (STEP_SIZE/2 - 1)
			xRel += offset
			#print(xRel)
			xRel = snap(STEP_SIZE, xRel)
			xRel -= offset
			#move self to snap position
			self.position.x = currentLog.position.x + xRel
		
		#DIE in water
		if ( self.position.y < 400 and not is_jumping() and not currentLog):
			get_tree().reload_current_scene()
		
		#snap to world grid on Y axis in case there is a slight shift
		self.position.y = snap(JUMP_SIZE, self.position.y)
		
		if Input.is_action_just_pressed("ui_left"):
			self.position.x -= STEP_SIZE
		elif Input.is_action_just_pressed("ui_right"):
			self.position.x += STEP_SIZE
		#clip position to screen
		self.position.x = clip(0, screen_x, self.position.x)
		
	if is_jumping():
		velocity.y = -jumpSpeed * jumpDir
		
	self.position += velocity * delta


