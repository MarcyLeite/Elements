extends Node2D
class_name Inventory

@onready var slot_list = $Slots.get_children() as Array[InventorySlot]
@onready var tab_list = $Tabs.get_children() as Array[InventorySlot]
@onready var description_node = $Description

var _items_dict: Dictionary = {}

const LINE_COUNT = 4
const COLUMN_COUNT = 5

var _selected_item_index: int = 0:
	set(value):
		var slot_count = LINE_COUNT * COLUMN_COUNT
		if value < 0 or value >= slot_count: return
		_selected_item_index = value
		slot_list[_selected_item_index].select()
		
var _selected_tab_index: int = 0:
	set(value):
		if value < 0: value = len(tab_list) - 1
		elif value >= len(tab_list): value = 0
		_selected_tab_index = value
		_populate()
		tab_list[_selected_tab_index].select()
		slot_list[_selected_item_index].select()

func _connect_slots(list):
	var i = 0
	for slot in list as Array[InventorySlot]:
		slot.index = i
		slot.on_selected.connect(_on_item_select)
		for to_connect_slot in list:
			if slot == to_connect_slot:
				continue
			slot.on_selected.connect(to_connect_slot.unselect)
		i += 1
		
func _populate():
	var _selected_tab_id = tab_list[_selected_tab_index].id
	var item_list = _items_dict[_selected_tab_id] as Array[Item]
	var i = 0
	for slot in slot_list:
		var item: Item = null
		if i < len(item_list): item = item_list[i]
		
		slot.update_item(item)
		i += 1

func _on_item_select(slot: InventorySlot):
	var item = slot.item
	var description_text = ''
	if item: description_text = item.description
	
	description_node.get_node('Label').text = description_text

func _ready():
	for tab in tab_list as Array[InventoryTab]:
		_items_dict[tab.id] = []
	_connect_slots(slot_list)
	_connect_slots(tab_list)
	toggle(false)

var _just_toggle = false
func _process(_delta):
	if _just_toggle:
		_just_toggle = false
		return
	
	if Input.is_action_just_pressed('left'):
		_selected_item_index -= 1
	elif Input.is_action_just_pressed('right'):
		_selected_item_index += 1
	elif Input.is_action_just_pressed('up'):
		_selected_item_index -= 5
	elif Input.is_action_just_pressed('down'):
		_selected_item_index += 5
	
	if Input.is_action_just_pressed('inventory_tab_prev'):
		_selected_tab_index -= 1
	if Input.is_action_just_pressed('inventory_tab_next'):
		_selected_tab_index += 1
	
	if Input.is_action_just_pressed('toggle_inventory'):
		toggle(false)

func toggle(value):
	_just_toggle = true
	get_tree().paused = value
	visible = value
	if value: 
		process_mode = Node.PROCESS_MODE_ALWAYS
		_selected_tab_index = 0
		_selected_item_index = 0
	else:
		process_mode = Node.PROCESS_MODE_DISABLED

func add_item(item: Item, _addons = {}):
	if item is Weapon:
		_items_dict.weapons.append(item)
	else:
		_items_dict.resources.append(item)
