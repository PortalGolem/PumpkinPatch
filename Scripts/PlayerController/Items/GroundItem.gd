class_name GroundItem

extends Node3D

@export var itemScene:PackedScene
var item:Item

func _ready() -> void:
	if itemScene:
		item = itemScene.instantiate()
		item.droppedItem = self

func pickupItem():
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	return item
