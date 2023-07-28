extends Node2D
class_name InventorySlot

signal on_selected

@onready var default_node: Sprite2D = $Default
@onready var selected_node: Sprite2D = $Selected
@onready var label_node: Label = $Label

var item: Item
var index = 0

func _toggle(value):
	default_node.visible = not value
	selected_node.visible = value

func update_item(new_item: Item):
	item = new_item
	if item:
		label_node.text = item.g_name.left(1)
	else:
		label_node.text = ''

func unselect(_new_selection):
	_toggle(false)

func select():
	on_selected.emit(self)
	_toggle(true)
