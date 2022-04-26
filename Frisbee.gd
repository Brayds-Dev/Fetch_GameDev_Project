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

# Set a random point on the map for the frisbee to land on
func _ready():
	var rand_int = randi_range(10, 500)
	point = Vector2(0, rand_int)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# code to switch the current state of the frisbee
	match state:
		HELD:
			held_state(delta)
		THROW:
			throw_state(delta)
		CAUGHT:
			caught_state(delta)

func _on_Timer_frisbee_timeout(): # After time throw the frisbee
	state = THROW

# Once frisbee area has entered that of the players
# the frisbee disappears
func _on_Frisbee_area_entered(area):
	if area == player_area:
		visible = false
		state = CAUGHT
		

# Code to handle frisbee movement
func throw_state(delta):
	if position.y < point.y:
		velocity = velocity.move_toward(point, delta)
		velocity = velocity.normalized() * MOVE_SPEED
		position += velocity
	else:
		velocity = Vector2.ZERO


func caught_state(delta):
	velocity = Vector2.ZERO
	position = Vector2(0,-1)
func held_state(delta):
	velocity = Vector2.ZERO

# Function to create a random integer within a range that can take negatives
func randi_range(from, to):
	if from > to:
		var old_from = from
		from = to
		to = old_from
	return int(floor(rand_range(from , to + 1)))
