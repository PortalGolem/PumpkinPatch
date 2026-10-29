extends Node3D

@export var MAX_PATCHES := 5
@export var MIN_PATCHES := 3
@export var MIN_DISTANCE_BETWEEN_PATCHES := 5.0
@export var MAX_PUMPKINS_PER_PATCH := 4
@export var MIN_PUMPKINS_PER_PATCH := 1
@export var MIN_DISTANCE_BETWEEN_PUMPKINS := 5.0
@export var WHOLE_PATCH_SIZE := 20.0
@export var PATCH_SIZE := 4
@export var pumpkin = preload("res://Objects/Enviornment/pumpkin.tscn")

var patchPositions:Array[Vector2]
var pumpkinPositions = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var patchCount = randi_range(MIN_PATCHES, MAX_PATCHES)
	for i in range(patchCount):
		patchPositions.append(get_random_vector_with_bufferzone(
				WHOLE_PATCH_SIZE, 
				MIN_DISTANCE_BETWEEN_PATCHES, 
				patchPositions))
				
	for v in range(patchPositions.size()):
		pumpkinPositions.append([])
		var pumpkinCount = randi_range(MIN_PUMPKINS_PER_PATCH, MAX_PUMPKINS_PER_PATCH)
		for i in range(pumpkinCount):
			pumpkinPositions[v].append(get_random_vector_with_bufferzone(
				PATCH_SIZE,
				MIN_DISTANCE_BETWEEN_PUMPKINS,
				pumpkinPositions[v]
			))
			var currentPumpkin = pumpkin.instantiate()
			add_child(currentPumpkin)
			currentPumpkin.position = Vector3(pumpkinPositions[v][i].x + patchPositions[v].x, position.z, pumpkinPositions[v][i].y + patchPositions[v].y)
	

func get_random_vector_with_bufferzone(distance:float, min_seperation: float, otherVectors:Array) -> Vector2:
	var testPos = Vector2(
		randf_range(-distance, distance), 
		randf_range(-distance, distance))
	for v in patchPositions:
		if v.distance_to(testPos) < min_seperation:
			return get_random_vector_with_bufferzone(distance, min_seperation, otherVectors)
	return testPos
