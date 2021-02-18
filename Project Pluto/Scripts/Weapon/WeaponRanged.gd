class_name RangedWeapon
extends Weapon


export var PROJECTILE_SCENE: PackedScene
export var PROJECTILE_SPEED: float


func use_special(attack_dir: float) -> void:
	.use_special(attack_dir)

func create_projectile(attack_dir: float) -> void:
	var projectile = PROJECTILE_SCENE.instance()
	get_tree().get_root().add_child(projectile)
	
	projectile.position = get_global_position()
	projectile.rotation = attack_dir
	projectile.velocity = Vector2.RIGHT.rotated(attack_dir) * PROJECTILE_SPEED
	projectile.entity = get_entity()
