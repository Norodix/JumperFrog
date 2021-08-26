extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const STEP_SIZE = 32
var velocity = Vector2()
var jumping = false
var jumpSpeed = 0

var screen_x = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_x = get_viewport().get_visible_rect().size.x
	jumpSpeed = STEP_SIZE / $JumpTimer.wait_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up") && !jumping:
		$JumpTimer.start()
		pass
		
func is_jumping():
	return !$JumpTimer.is_stopped()
	
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
		
		#snap to world grid on Y axis in case there is a slight shift
		self.position.y = snap(STEP_SIZE, self.position.y)
		
		if Input.is_action_just_pressed("ui_left"):
			self.position.x -= STEP_SIZE
		elif Input.is_action_just_pressed("ui_right"):
			self.position.x += STEP_SIZE
		#clip position to screen
		self.position.x = clip(0, screen_x, self.position.x)
		
	if is_jumping():
		velocity.y = -jumpSpeed*delta
		
	move_and_collide(velocity)
