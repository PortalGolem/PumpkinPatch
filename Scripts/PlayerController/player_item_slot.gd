class_name PlayerItemSlot

extends Node3D

@export var DEFAULT_ITEM:Item = null
@export var currentItem:Item = null

@onready var itemCast:RayCast3D = $RayCast3D
var lookingAtGroundItem:GroundItem = null

var currentItems:Array[Item] = [DEFAULT_ITEM]

func _ready() -> void:
	if currentItem == null:
		currentItem = DEFAULT_ITEM
	currentItem.equip_item()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		if currentItem != DEFAULT_ITEM and itemCast.is_colliding():
			currentItem.drop_item(itemCast.get_collision_point())
			DEFAULT_ITEM.equip_item()
			currentItem = DEFAULT_ITEM
		elif lookingAtGroundItem != null:
			DEFAULT_ITEM.store_item()
			currentItem = lookingAtGroundItem.pickupItem()
			currentItem.equip_item(self)
			lookingAtGroundItem = null
	
	if event.is_action_pressed("Use"):
		currentItem.use_item()
		
func _physics_process(_delta: float) -> void:
	
	lookingAtGroundItem = null
	
	if itemCast.is_colliding():
		var hitObject := itemCast.get_collider()
		
		if hitObject is GroundItem:
			lookingAtGroundItem = hitObject
		for item:Item in currentItems:
			# add more behavior here for different kinds of item interactions.
			if item is AxeItem and hitObject is Axeable:
				print("Found axeable!")
				item.targetAxeable = hitObject
				# hello! have you seen the rain Its really cool :) 
				# its really cool
