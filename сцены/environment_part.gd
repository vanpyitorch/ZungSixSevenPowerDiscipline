#extends Node3D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
extends Node3D
func _process(delta):
	position.z += 10.0 * delta
	print("Забор летит! Z: ", position.z)
