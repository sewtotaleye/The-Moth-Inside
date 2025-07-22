extends Control

var main_ref = null 

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
        var callable = Callable(self, "_on_answer_pressed").bind(i)
        if answer_buttons[i].is_connected("pressed", callable):
         answer_buttons[i].disconnect("pressed", callable)
        answer_buttons[i].connect("pressed", callable)

func _on_answer_pressed(answer_index):
    var current_answers = questions[current_question]["answers"]
    if answer_index >= current_answers.size():
        print("Invalid answer index:", answer_index)
        return

    var selected = current_answers[answer_index]
    for t in selected["traits"]:
        collected_traits[t] = collected_traits.get(t, 0) + 1

    current_question += 1

    if current_question < questions.size():
        display_question()
    else:
        show_result()

func show_result():
    var parent = get_parent()
    if parent.has_method("load_result"):
        parent.load_result(collected_traits)
    else:
        print(" parent is null or missing load_result()")
