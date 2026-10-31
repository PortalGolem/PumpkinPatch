extends Node3D

@export var DEFAULT_ITEM:Item = null
@export var currentItem:Item = null

var lookingAtItem:Item = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		if currentItem != DEFAULT_ITEM:
			currentItem.drop_item()
			DEFAULT_ITEM.equip_item()
			currentItem = DEFAULT_ITEM
		elif lookingAtItem != null:
			DEFAULT_ITEM.store_item()
			lookingAtItem.equip_item()
			currentItem = lookingAtItem
			lookingAtItem = null
	
	if event.is_action_pressed("Use"):
		currentItem.use_item()
