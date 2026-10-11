extends CharacterBody3D


const SPEED = 5.0

@export var player: CharacterBody3D # Or Node3D, depending on its type

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction: Vector3 = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	
	var target_angle = atan2(-direction.x, -direction.z)
	$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, target_angle, 10.0 * delta)
	
	if distance > 3:
		velocity.z = direction.z * SPEED 
		velocity.x = direction.x * SPEED
	else:
		velocity.z = 0
		velocity.x = 0

	move_and_slide()
