extends CharacterBody3D

var xp = 0.0
var lvl = 1

var stealth_lvl = 1.0
var int_lvl = 1.0
var speed_lvl = 1.0

var stamina = 100.0

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
	if direction.length() >= 0.1:
		var target_angle = atan2(-direction.x, -direction.z)
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, target_angle, 10.0 * delta)
	if direction:
		velocity.x = direction.x * (speed_lvl + 5)
		velocity.z = direction.z * (speed_lvl + 5)
	else:
		velocity.x = move_toward(velocity.x, 0, (speed_lvl + 5))
		velocity.z = move_toward(velocity.z, 0, (speed_lvl + 5))

	move_and_slide()
