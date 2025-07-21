extends Node
var questions = []
var current_question = 0
var traits = {} #player earned traits for fnl mothhhh

@onready var question_label = $VBoxContainer/Label
@onready var answer_buttons = [
	$VBoxContainer/Answer1,
	$VBoxContainer/Answer2,
	$VBoxContainer/Answer3,
	$VBoxContainer/Answer4
]
func _ready():
	load_questions()
	display_question()
	
func load_questions():
	var file = FileAccess.open("res://data/questions.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		questions = JSON.parse_string(content)
		
func display_question():
	var q = questions[current_question]
	question_label.txt = q["question"]
	
	for i in range(answer_buttons.size()):
		var answer = q["answers"][i]
		answer_buttons[i].text = answer["text"]
		answer_buttons[i].disconnect("pressed", self, "_on_answer_pressed") 
		answer_buttons[i].connect("pressed", Callable(self, "_on_answer_pressed").bind(i))
func _on_answer_pressed(answer_index):
	var selected = questions[current_question]["answers"][answer_index]
	for traits in selected["traits"]:
		if !traits.has(traits):
			traits[traits] = 1
		else:
			traits[traits] += 1
	current_question += 1
	if current_question < questions.size():
		display_question()
	else:
		show_result()
		
func show_result():
	var main = get_tree().get_root().get_node("main")
	main.load_result(traits)
			
