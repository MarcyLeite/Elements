extends StateAnimated
class_name StateWalk

@export var speed: float = 300

func physics_update(_delta):
	if owner.action_direction == Vector2.ZERO:
		state_changed.emit(self, 'StateIdle')
		return
	if owner.attack_scene:
		state_changed.emit(self, 'StateAttack')
		return
	
	_animation_direction = owner.action_direction
	super(_delta)
		
	owner.velocity = owner.action_direction * speed
	owner.move_and_slide()
	
