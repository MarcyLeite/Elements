@tool
extends State
class_name StateAnimated

@export var animator: AnimationPlayer:
	get:
		if not animator:
			return owner.get_node('AnimationPlayer')
		return animator
		
@export var animator_key: String:
	get:
		if not animator_key:
			return self.get_name()
		return animator_key
var _animation_direction: Vector2

func physics_update(_delta):
	if _animation_direction == null:
		return
	
	var angle = rad_to_deg(_animation_direction.angle())
	if angle > -135 and angle < -45:
		animator.play('%sUp' % (animator_key))
	elif angle >= -45 and angle <= 45:
		animator.play('%sRight' % (animator_key))
	elif angle > 45 and angle < 135:
		animator.play('%sDown' % (animator_key))
	elif angle >= 135 or angle <= -135:
		animator.play('%sLeft' % (animator_key))
	
