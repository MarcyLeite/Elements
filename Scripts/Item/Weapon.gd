extends Item
class_name Weapon

enum Type {
	SWORD
}

var light_attack_list: Array[PackedScene] = []

@export var weapon_type: Type
@export var base_damage: float = 0
