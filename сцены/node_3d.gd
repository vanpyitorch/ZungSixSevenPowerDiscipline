extends CharacterBody3D

const SPEED = 10.0
const LANE_WIDTH = 1.5

# Ссылка на камеру (если не найдет автоматически, укажи точное имя)
@onready var cam = $Camera3D 

func _physics_process(delta):
	# 1. БЕГ ВПЕРЕД (Диона сама летит в минус по Z)
	velocity.z = -SPEED
	
	# 2. ВЛЕВО (грубо меняем X)
	if Input.is_action_just_pressed("ui_left"):
		position.x -= LANE_WIDTH
		print("Влево! X: ", position.x)

	# 3. ВПРАВО (грубо меняем X)
	if Input.is_action_just_pressed("ui_right"):
		position.x += LANE_WIDTH
		print("Вправо! X: ", position.x)

	# 4. ПРЫЖОК (грубо меняем Y)
	if Input.is_action_just_pressed("ui_accept"):
		position.y += 1.5
		print("Прыжок! Y: ", position.y)
		
	# 5. Гравитация для возврата (чтобы не висела в воздухе)
	var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	if position.y > 0:
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
		position.y = 0

	# 6. ПРИКЛЕИВАЕМ КАМЕРУ (Самое важное!)
	if cam:
		# Ставим камеру на 3 метра выше и на 6 метров позади Дионы
		cam.global_position = global_position + Vector3(0, 3, 6)
		# Заставляем камеру смотреть прямо на Диону
		cam.look_at(global_position + Vector3(0, 1.5, 0))

	move_and_slide()
