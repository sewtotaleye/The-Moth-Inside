extends Control

var collected_traits = {}

@onready var name_label = $VBoxContainer/Label
@onready var moth_image = $VBoxContainer/TextureRect
@onready var blurb_label = $VBoxContainer/Label2
@onready var restart_button = $VBoxContainer/Button

func _ready():
    restart_button.text = "Try Again"
    restart_button.connect("pressed", Callable(self, "_on_restart_pressed"))

func set_traits(traits: Dictionary) -> void:
    # You can update this logic later to display results
    print("Collected traits:", traits)

func display_result():
    # 1. Pick a name based on traits
    name_label.text = generate_name()

    # 2. Pick an image (TEMP: placeholder moth)
    moth_image.texture = preload("res://assets/moth_parts/sample_moth.png")

    # 3. Poetic blurb
    blurb_label.text = generate_blurb()

func generate_name():
    # Very simple placeholder name logic
    var words = ["Lantern", "Whisper", "Veil", "Dust", "Flicker"]
    return "The " + words[randi() % words.size()] + " Moth"

func generate_blurb():
    return "You move gently through the world, shaped by what you hold close."

func _on_restart_pressed():
    get_tree().reload_current_scene()  # Quick and dirty restart for jam
