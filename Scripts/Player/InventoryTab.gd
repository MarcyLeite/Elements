extends InventorySlot
class_name InventoryTab

static var id_list: Array[String] = []

@export var id: String
@export var g_name: String

func _init():
	if id in id_list:
		assert('ERROR: id has to be unique [%s].' % id)
	id_list.append(id)

func _ready():
	item_icon.text = g_name
