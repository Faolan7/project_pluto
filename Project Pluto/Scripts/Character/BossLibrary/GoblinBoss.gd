extends Enemy


var changed_phase: bool = false

onready var melee_weapon: Weapon = $Sprite/FacingPivot/Maul as Weapon
onready var ranged_weapon: Weapon = $Sprite/FacingPivot/Bow as Weapon


func _ready() -> void:
	set_ranged_phase()

func _physics_process(_delta: float) -> void:
	if not changed_phase and get_health_percent() < 50:
		changed_phase = true
		set_stamina(get_max_stamina())
		set_melee_phase()


func set_melee_phase() -> void:
	combat_distance = 22 * sprite.scale.length()
	set_weapon(melee_weapon)
	move_state.MOVE_SPEED = 100

func set_ranged_phase() -> void:
	combat_distance = 400 * sprite.scale.length()
	set_weapon(ranged_weapon)
	move_state.MOVE_SPEED = 50
