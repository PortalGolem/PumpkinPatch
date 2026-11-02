class_name Item
extends Node3D

# This class and it's children will handle all visuals and physics assosiated with these functions.
# The player item class will simply call them and they will also inherit the posiiton from
# player item slot class.d

#Hello!

var droppedItem:GroundItem

func use_item():
	pass

func drop_item(targetPosition:Vector3):
	droppedItem.visible = true
	droppedItem.process_mode = Node.PROCESS_MODE_INHERIT
	droppedItem.global_position = targetPosition
	visible = false

func equip_item(parentToSet:Node3D = null):
	visible = true
	if parentToSet and not self.get_parent():
		parentToSet.add_child(self)

func store_item():
	pass
