extends Node3D

@export var track_scene: PackedScene # Сюда перетащи файл railroad-straight.glb
@export var track_length: float = 10.0 # Длина ОДНОГО куска
@export var num_tracks: int = 30 # Сколько кусков создаем (30 * 10 = 300 метров дороги)
@export var speed: float = 15.0 # Скорость движения на игрока

var tracks = [] # Массив, где хранятся наши рельсы

func _ready():
	# Создаем дорогу при старте
	for i in range(num_tracks):
		var new_track = track_scene.instantiate()
		new_track.position = Vector3(0, 0, -i * track_length) # Ставим друг за другом
		add_child(new_track)
		tracks.append(new_track)

func _process(delta):
	# Двигаем каждую рельсу
	for track in tracks:
		track.position.z += speed * delta
		
		# Если рельса улетела за спину Дионы (Z > 20)
		if track.position.z > 20.0:
			# Находим, какая рельса сейчас самая дальняя (с самым маленьким Z)
			var min_z = 0.0
			for t in tracks:
				if t.position.z < min_z:
					min_z = t.position.z
			
			# Ставим улетевшую рельсу перед самой дальней (в конец очереди)
			track.position.z = min_z - track_length
