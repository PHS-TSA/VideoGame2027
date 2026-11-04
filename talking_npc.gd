extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var player: CharacterBody3D


func _physics_process(delta: float) -> void:
	var distance = global_position.distance_to(player.global_position)

	if distance < 5 && Input.is_action_just_pressed("interact"):
		print("interaction") 
		
	
