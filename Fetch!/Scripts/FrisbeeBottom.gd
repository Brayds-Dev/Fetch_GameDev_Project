extends Area2D

onready var player_area = get_node("/root/World/Player/Area2D") # Reference to the player node

# Set initial variables
const MOVE_SPEED = 2
var velocity = Vector2.ZERO
var point = Vector2.ZERO

enum {
	THROW,
	CAUGHT,
	HELD
}
var state = HELD

# Assign a vector on map to point this object to
func _ready():
	var random = randi_range(-20, -400)
	point = Vector2(0, random) 

func _physics_process(delta):
	# code to switch the current state of the frisbee
	match state:
		HELD:
			held_state(delta)
		THROW:
			throw_state(delta)
		CAUGHT:
			caught_state(delta)
			

# When object state is set to throw move object towards point
func throw_state(delta):
	if position.y > point.y:
		velocity = velocity.move_toward(point, delta)
		velocity = velocity.normalized() * MOVE_SPEED
		position += velocity
	else:
		velocity = Vector2.ZERO

# When object state is set to caught reasign position
func caught_state(delta):
	velocity = Vector2.ZERO
	position = Vector2(0,-1)
	
func held_state(delta):
	velocity = Vector2.ZERO

# Throw frisbee after timer has elapsed
func _on_Timer_frisbee_bottom_timeout():
	state = THROW

# Once players area has entered frisbees change state to caught and make visible false
func _on_FrisbeeBottom_area_entered(area):
	if area == player_area:
		visible = false
		state = CAUGHT

# Function to create a random integer within a range that can take negatives
func randi_range(from, to):
	if from > to:
		var old_from = from
		from = to
		to = old_from
	return int(floor(rand_range(from , to + 1)))
