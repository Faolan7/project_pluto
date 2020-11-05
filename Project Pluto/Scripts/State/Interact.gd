extends State

export(NodePath) var INTERACTION_AREA: NodePath # Path to the actor node

var interaction_area: Area2D

func _ready():
	interaction_area = get_node(INTERACTION_AREA) as Area2D
	
func activate():
	.activate()
		
	var bodies = interaction_area.get_overlapping_bodies()
	
	if bodies.size() == 0:
		return
	
	var shortest_distance: float = INF
	var closest_body: PhysicsBody2D
	
	for body in bodies:
		var current_distance: float = actor.position.distance_squared_to(body.position)
		if current_distance < shortest_distance:
			closest_body = body
			shortest_distance = current_distance
	
	closest_body.interact()
