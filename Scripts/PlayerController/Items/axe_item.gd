class_name AxeItem

extends Item

var isActive:bool = false
var targetAxeable:Axeable = null

func equip_item(_parentToSet:Node3D = null):
	isActive = true
	visible = true

func store_item():
	isActive = false
	visible = false

func use_item():
	if isActive && targetAxeable:
		targetAxeable.hit()
  
# Use:
#	f
#	This should swing forwards and look for things in the 'Axeable' layer.                   
#	if it finds something it will do all the interaction things its supposed to do

func drop_item(_targetPosition:Vector3):
	pass
