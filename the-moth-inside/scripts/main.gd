extends Node
func _ready():
	load_quiz()
	
func load_quiz():
	var quiz = preload("res://scenes/quiz/quiz_scene.tscn").instantiate()
	add_child(quiz)
	
	
func load_result(result_data):
	
	for child in get_children():
		child.queue_free()
	var result = preload("res://scenes/result/result_scene.tscn").instantiate() 
	result.set_traits(result_data)
	add_child(result)
