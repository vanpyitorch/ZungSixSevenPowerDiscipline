extends Node3D

@export var track_scene: PackedScene 
@export var track_length: float = 10.0 
@export var num_tracks: int = 30 
@export var speed: float = 15.0 
@export var lane_width: float = 1.5 # Расстояние между полосами (+-1.5)

var tracks = []

func _ready():
	# Создаем очередь из 3-х полос
	for i in range(num_tracks):
		# Создаем левую, центральную и правую рельсу для каждого шага
		spawn_three_lanes(-i * track_length)

func spawn_three_lanes(z_pos):
	# Левая (-1.5)
	var left = track_scene.instantiate()
	left.position = Vector3(-lane_width, 0, z_pos)
	add_child(left)
	tracks.append(left)
	
	# Центральная (0)
	var center = track_scene.instantiate()
	center.position = Vector3(0, 0, z_pos)
	add_child(center)
	tracks.append(center)
	
	# Правая (+1.5)
	var right = track_scene.instantiate()
	right.position = Vector3(lane_width, 0, z_pos)
	add_child(right)
	tracks.append(right)

func _process(delta):
	# Считаем общую длину всей очереди (сколько рельс * их длину)
	var total_length = num_tracks * track_length
	
	for track in tracks:
		track.position.z += speed * delta
		
		# Если рельса улетела за спину
		if track.position.z > 20.0:
			# Просто сдвигаем её на всю длину очереди назад
			track.position.z -= total_length
