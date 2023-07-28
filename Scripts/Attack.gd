extends Node2D
class_name Attack

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var area2D: Area2D = $Area2D

func _ready():
	area2D.collision_layer = 4
	animationPlayer.play('Execute')
	animationPlayer.animation_finished.connect(_finish)

func _finish(_animation_name):
	queue_free()
