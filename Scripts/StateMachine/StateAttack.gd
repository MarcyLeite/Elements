extends State
class_name StateAttack

func enter():
	var attack = owner.attack_scene.instantiate() as Attack
	owner.add_child(attack)
	attack.name = 'ActiveAttack'
	attack.animationPlayer.animation_finished.connect(_on_animation_finished)
	attack.rotation = owner.last_direction.angle()

func exit():
	owner.attack_scene = null

func _on_animation_finished(_name):
	state_changed.emit(self, 'StateIdle')
