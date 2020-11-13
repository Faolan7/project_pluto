extends State


export(NodePath) var INTERACTION_AREA: NodePath # Path to the actor node

var interaction_area: Area2D


func _ready() -> void:
	interaction_area = get_node(INTERACTION_AREA) as Area2D


func activate() -> void:
	.activate()
	is_completed = false
	
	var closest_object: CollisionObject2D = get_closest_object()
	
	if closest_object == null:
		is_completed = true
	else:
		# warning-ignore:return_value_discarded
		closest_object.connect('interaction_finished', self, '_on_interaction_finished',
			[], CONNECT_ONESHOT)
			
		closest_object.interact()


func get_closest_object() -> CollisionObject2D:
	var objects: Array = interaction_area.get_overlapping_areas()
	
	if objects.size() == 0:
		return null
	
	var shortest_distance: float = INF
	var closest_object: CollisionObject2D
	
	for object in objects:
		var current_distance: float = actor.position.distance_squared_to(object.position)
		if current_distance < shortest_distance:
			closest_object = object
			shortest_distance = current_distance
			
	return closest_object


func _on_interaction_finished() -> void:
	is_completed = true
