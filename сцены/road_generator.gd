extends Node3D

var speed = 15.0
var track_scene = preload("res://assets/railroad-straight.glb") # Укажи свой путь!
var lane_width = 1.5
var num_tracks = 30
var track_length = 4.5

var tracks = []

func _ready():
	# Создаем начальную очередь
	for i in range(num_tracks):
		spawn_lane(-i * track_length)

func spawn_lane(z_pos):
	# Левая
	var left = track_scene.instantiate()
	left.position = Vector3(-lane_width, 0, z_pos)
	add_child(left)
	tracks.append(left)
	
	# Центр
	var center = track_scene.instantiate()
	center.position = Vector3(0, 0, z_pos)
	add_child(center)
	tracks.append(center)
	
	# Правая
	var right = track_scene.instantiate()
	right.position = Vector3(lane_width, 0, z_pos)
	add_child(right)
	tracks.append(right)

func _process(delta):
	# Двигаем рельсы строго по Z, игнорируя всё остальное
	for track in tracks:
		track.position.z += speed * delta
		
		# Если улетела за спину
		if track.position.z > 20.0:
			var min_z = 0.0
			for t in tracks:
				if t.position.z < min_z:
					min_z = t.position.z
			
			# Телепортируем в конец
			track.position.z = min_z - track_length
