extends Area2D
class_name  HurtBox

func _on_hurt(hitbox: Hitbox):
	print('ai D:')

func _ready():
	connect('area_entered', _on_hurt)

func _init():
	collision_layer = 0
	collision_mask = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
