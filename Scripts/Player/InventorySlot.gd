extends Node2D
class_name InventorySlot

signal on_selected 

@onready var default_node: Sprite2D = $Default
@onready var selected_node: Sprite2D = $Selected
@onready var item_icon: Label = $ItemIcon
var equip_icon: Label

var item: Item
var index = 0

func _ready():
	if $EquipIcon: equip_icon = $EquipIcon
	else: equip_icon = Label.new()
	
	selected_node.visible = false
	equip_icon.visible = false

func _toggle(value):
	default_node.visible = not value
	selected_node.visible = value

func update_item(new_item: Item):
	item = new_item
	if item:
		item_icon.text = item.g_name.left(1)
	else:
		item_icon.text = ''

func select():
	on_selected.emit(self)
	_toggle(true)

func unselect(_new_selection):
	_toggle(false)
	
func toggle_equip_item(value):
	equip_icon.visible = value
