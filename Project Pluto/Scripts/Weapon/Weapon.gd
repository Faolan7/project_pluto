class_name Weapon
extends Sprite


signal attack_finished
signal special_finished
signal attack_range_entered


var entity: Node2D setget set_entity, get_entity
var attack_hitbox: Hitbox
var special_hitbox: Hitbox

onready var attack_range: Area2D = $AttackRange as Area2D
onready var attack_range_shape: CollisionShape2D = $AttackRange/CollisionShape2D as CollisionShape2D
onready var animation_player: AnimationPlayer = $AnimationPlayer as AnimationPlayer
onready var tween: Tween = $Tween as Tween

export(String) var attack_name: String = ''
export(float) var attack_stamina_cost: float
export(NodePath) var attack_hitbox_path: NodePath
export(String) var special_name: String = ''
export(float) var special_stamina_cost: float
export(NodePath) var special_hitbox_path: NodePath
export(PackedScene) var projectile_scene: PackedScene
export(float) var projectile_speed: float


func _ready() -> void:
	if not attack_hitbox_path.is_empty():
		attack_hitbox = get_node(attack_hitbox_path)
	if not special_hitbox_path.is_empty():
		special_hitbox = get_node(special_hitbox_path)

func use(attack_dir: float) -> void:
	if attack_name != '':
		Attacks.perform(attack_name, self, false, attack_dir)

func use_special(attack_dir: float) -> void:
	if special_name != '':
		Attacks.perform(special_name, self, true, attack_dir)

# Wrapper for tween node; used for on-the-fly animations
func play_tween(object: Object, property: String,
		initial_val, final_val, duration: float,
		trans_type: int = 0, ease_type: int = 2, delay: float = 0) -> void:
	# warning-ignore:return_value_discarded
	tween.interpolate_property(object, property, initial_val, final_val, duration,
		trans_type, ease_type, delay)
	# warning-ignore:return_value_discarded
	tween.start()

func has_entity_in_range(target) -> bool: # Target should be Character
	return attack_range.get_overlapping_areas().has(target.hurtbox)

func create_projectile(attack_dir: float) -> void:
	var projectile = projectile_scene.instance()
	entity.get_parent().add_child(projectile)
	
	projectile.position = entity.position + position
	projectile.rotation = attack_dir
	projectile.velocity = Vector2.RIGHT.rotated(attack_dir) * projectile_speed
	projectile.entity = get_entity()


func set_entity(value: PhysicsBody2D) -> void:
	entity = value
	
	if attack_hitbox != null: attack_hitbox.entity = entity
	if special_hitbox != null: special_hitbox.entity = entity
	attack_range_shape.set_deferred('disabled', value == null or not value.is_class('Enemy'))

func get_entity() -> Node2D:
	return entity

func set_hitbox_enabled(value: bool, special: bool = false) -> void:
	if special:
		if special_hitbox != null: special_hitbox.shape.disabled = not value
	else:
		if attack_hitbox != null: attack_hitbox.shape.disabled = not value


func _on_animation_finished(anim_name: String) -> void:
	match anim_name:
		'attack': emit_signal('attack_finished')
		'special': emit_signal('special_finished')

func _on_tween_finished(_object: Object, _key: NodePath):
	if attack_hitbox != null: attack_hitbox.shape.disabled = true
	if special_hitbox != null: special_hitbox.shape.disabled = true

func _on_attack_range_entered(area: Area2D) -> void:
	if area.get_parent() != entity:
		emit_signal('attack_range_entered')
