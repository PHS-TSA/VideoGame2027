extends CharacterBody3D


const SPEED = 5.0


@export var player: CharacterBody3D # Or Node3D, depending on its type
var isFollowing = false 
var isInitalPositionRecorded = false 
#var isCurrentPositionRecorded = false 
var init_position: Vector3 = global_position
#var current_position: Vector3 = global_position




func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var distance = global_position.distance_to(player.global_position)
	
	if distance < 5:
		isFollowing = true
	elif distance > 10:
		isFollowing = false 
	
	if isInitalPositionRecorded == false: 
		init_position = global_position
		print(init_position)
		isInitalPositionRecorded = true 
		
	if isFollowing: 
		var direction: Vector3 = global_position.direction_to(player.global_position)
		var target_angle = atan2(-direction.x, -direction.z)
		$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, target_angle, 10.0 * delta)
		if distance > 1: #adjust this to when they are really close (almost touching)
			velocity.z = direction.z * SPEED 
			velocity.x = direction.x * SPEED  
		else:  #set this to lose condition (die condition) 
			velocity.z = 0 
			velocity.x = 0 
			#isCurrentPositionRecorded = false
	else:
		if global_position.distance_to(init_position) < 1:
			velocity.z = 0
			velocity.x = 0
			$MeshInstance3D.rotation = Vector3.ZERO #reset to original position
			print("at inital")
		else: 
			#if isCurrentPositionRecorded == false:
				#current_position = global_position
				#print(current_position)
				#isCurrentPositionRecorded = true 
			var init_direction: Vector3 = global_position.direction_to(init_position)
			var target_angle = atan2(-init_direction.x, -init_direction.z)
			$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, target_angle, 10.0 * delta)
			velocity.z = init_direction.z * SPEED 
			velocity.x = init_direction.x * SPEED
			
			#not exactly at inital bt close enough... figure how to do that 
				
	move_and_slide()
