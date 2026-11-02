extends CharacterBody3D

const SPEED = 10.0 # Было 15.0, сделали 8.0
const JUMP_VELOCITY = 12.0 # Прыжок чуть выше
const LANE_SPEED = 10.0 # Плавнее перестраивалась
const LANE_WIDTH = 2.5
var current_lane = 0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	print("Диона: X=", position.x, " Y=", position.y, " Z=", position.z)
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("ui_left") and current_lane > -1:
		current_lane -= 1
	if Input.is_action_just_pressed("ui_right") and current_lane < 1:
		current_lane += 1

	var target_x = current_lane * LANE_WIDTH
	var target_velocity_x = (target_x - position.x) * LANE_SPEED
	
	velocity.z = -SPEED
	velocity.x = target_velocity_x
	print("Игрок Z: ", position.z, " | Камера Z: ", $Camera3D.global_position.z)
	move_and_slide()
