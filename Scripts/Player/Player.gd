extends CharacterBody2D
class_name Player

@onready var inventory: Inventory = $Inventory

var last_direction = Vector2.ZERO
var action_direction = Vector2.ZERO

var packed_attack_list = []
var attack_scene = null

func _init_attacks():
	var available_attacks = $AvailableAttacks.get_children()
	for attack in available_attacks:
		var packed_attack = load(attack.scene_file_path)
		packed_attack_list.append(packed_attack)
	
	$AvailableAttacks.queue_free()

func _ready():
	_init_attacks()
	inventory.add_item(load("res://Instances/Items/WoodenSword.tscn").instantiate())
	inventory.add_item(load("res://Instances/Items/Stone.tscn").instantiate())

func _process(_delta):
	action_direction = Input.get_vector("left", 'right', 'up', 'down')
	if Input.is_action_just_pressed('light_attack'):
		attack_scene = packed_attack_list[0]
	
	if Input.is_action_just_pressed('toggle_inventory'):
		get_tree().paused = true
		inventory.toggle(true)

func _physics_process(_delta):
	if action_direction != Vector2.ZERO:
		last_direction = action_direction.normalized()
