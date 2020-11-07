class_name Quest
extends Node


enum QuestState {UNSTARTED, STARTED, COMPLETED, TURNED_IN}

var KILL_TASK = load('res://Scenes/Quest/KillTask.tscn')
var REWARD = load('res://Scripts/Quest/Reward.gd')

var state: int = QuestState.UNSTARTED
var tasks: Array setget ,get_tasks
var rewards: Array = []

onready var TASK_NODE: Node = $Tasks


func init(enemyID: int, numOfEnemy: int, reward_data: Array) -> void:
	add_task(enemyID, numOfEnemy)
	
	var reward = REWARD.new()
	reward.init(reward_data[0], reward_data[1], reward_data[2])
	rewards.append(reward)

func add_task(enemy_id: int, quantity: int) -> void:
	var task = KILL_TASK.instance()
	TASK_NODE.add_child(task)
	
	task.init(enemy_id, quantity)
	task.connect('completed', self, '_on_task_completed')

func get_tasks() -> Array:
	return TASK_NODE.get_children()


func _on_task_completed():
	var is_completed: bool = true
	
	# Checking if all tasks are completed
	for task in get_tasks():
		if not task.is_complete:
			is_completed = false
			break
			
	if is_completed:
		state = QuestState.COMPLETED
