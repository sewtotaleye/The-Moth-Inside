extends Node

var questions = []
var current_question = 0
var collected_traits = {}

@onready var question_label = $CenterContainer/VBoxContainer/Question
@onready var answer_buttons = [
    $CenterContainer/VBoxContainer/Answer1,
    $CenterContainer/VBoxContainer/Answer2,
    $CenterContainer/VBoxContainer/Answer3,
    $CenterContainer/VBoxContainer/Answer4
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
    question_label.text = q["question"]
    
    for i in range(answer_buttons.size()):
        var answer = q["answers"][i]
        answer_buttons[i].text = answer["text"]
        answer_buttons[i].connect("pressed", Callable(self, "_on_answer_pressed").bind(i))

func _on_answer_pressed(answer_index):
    var selected = questions[current_question]["answers"][answer_index]
    
    for t in selected["traits"]:
        if !collected_traits.has(t):
            collected_traits[t] = 1
        else:
            collected_traits[t] += 1
            
    current_question += 1
    
    if current_question < questions.size():
        display_question()
    else:
        show_result()

func show_result():
    var main = get_tree().get_root().get_node("main")
    main.load_result(collected_traits)
            
