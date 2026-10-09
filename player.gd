extends CharacterBody3D

var xp = 0.0
var lvl = 1

var stealth_lvl = 1.0
var int_lvl = 1.0
var speed_lvl = 0 #only small increments 

var stamina = 100.0


@export var DODGE_SPEED = 20.0
var is_dodging = false
var dodge_direction = Vector3.ZERO
var is_cooldown = false 

@onready var dodge_timer = $DodgeTimer
@onready var dodge_cooldown = $DodgeCooldown

func start_dodge(dir: Vector3):
	is_dodging = true 
	is_cooldown = true 
	if dir == Vector3.ZERO:
		dodge_direction = Vector3.FORWARD.rotated(Vector3.UP, $MeshInstance3D.rotation.y).normalized()
	else:
		dodge_direction = dir 
	dodge_timer.start(0.2)
	dodge_cooldown.start(1)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("roll") and not is_dodging and not is_cooldown:
		start_dodge(direction)
	
	if direction.length() >= 0.1:
		var target_angle = atan2(-direction.x, -direction.z)
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, target_angle, 10.0 * delta)
	if is_dodging: 
		velocity.x = dodge_direction.x * DODGE_SPEED
		velocity.z = dodge_direction.z * DODGE_SPEED
	else:
		if direction:
			if Input.is_action_pressed("shift"):
				velocity.x = direction.x * (speed_lvl + 8)
				velocity.z = direction.z * (speed_lvl + 8)
			elif Input.is_action_pressed("Crouch"):
				velocity.x = direction.x * (3)
				velocity.z = direction.z * (3)
			else:
				velocity.x = direction.x * (speed_lvl + 5)
				velocity.z = direction.z * (speed_lvl + 5)
		else:
			velocity.x = move_toward(velocity.x, 0, (speed_lvl + 5))
			velocity.z = move_toward(velocity.z, 0, (speed_lvl + 5))

	move_and_slide()


func _on_timer_timeout() -> void:
	is_dodging = false


func _on_dodge_cooldown_timeout() -> void:
	is_cooldown = false 
	
