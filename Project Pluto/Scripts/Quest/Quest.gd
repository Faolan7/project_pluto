class_name Quest
extends Node


enum QuestState {UNSTARTED, STARTED, COMPLETED, TURNED_IN}

var KILL_TASK: Resource = load('res://Scripts/Quest/KillTask.gd')


var state: int = QuestState.UNSTARTED
var tasks: Array = []


func init(task_data: Array) -> void:
	for task in task_data:
		add_task(task)

func add_task(task_data: Dictionary) -> void:
	var task: Task = init_task(task_data)
	
	tasks.append(task)
	# warning-ignore:return_value_discarded
	task.connect('completed', self, '_on_task_completed')

func init_task(task_data: Dictionary) -> Task:
	var task: Task
	
	match task_data['type']:
		'kill':
			task = KILL_TASK.new()
			task.init(task_data['enemy'], task_data['quantity'])
		_: # Quit if unknown task
			return null
			
	return task


func _on_task_completed() -> void:
	var is_completed: bool = true
	
	# Checking if all tasks are completed
	for task in tasks:
		if not task.is_complete:
			is_completed = false
			break
			
	if is_completed:
		state = QuestState.COMPLETED
