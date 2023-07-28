extends StateAnimated
class_name StateIdle

func physics_update(_delta):
	if owner.action_direction != Vector2.ZERO:
		state_changed.emit(self, 'StateWalk')
		return
	if owner.attack_scene:
		state_changed.emit(self, 'StateAttack')
	
	_animation_direction = owner.last_direction
	super(_delta)
