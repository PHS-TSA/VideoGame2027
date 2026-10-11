extends CharacterBody3D


const SPEED = 5.0
var isForward = true  

@onready var direction_timer = $DirectionTimer

func _physics_process(delta: float) -> void:
	#no gravity so no falling (insert later)
	
	if isForward == true: 
		velocity.x = Vector3.RIGHT.x * SPEED
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, atan2(Vector3.LEFT.x, 0), 10.0 * delta)
		direction_timer.start
	else:
		velocity.x = Vector3.LEFT.x * SPEED 
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, atan2(Vector3.RIGHT.x, 0), 10.0 * delta)
		direction_timer.start
		

	move_and_slide()


func _on_timer_timeout() -> void:
	isForward = not isForward
