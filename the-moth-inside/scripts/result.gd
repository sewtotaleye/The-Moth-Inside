extends Control

@onready var name_label = $CenterContainer/VBoxContainer/name_label
@onready var blurb_label = $CenterContainer/VBoxContainer/blurb_label
@onready var moth_image = $CenterContainer/VBoxContainer/moth_image
@onready var trait_list = $CenterContainer/VBoxContainer/trait_list
@onready var restart_button = $CenterContainer/VBoxContainer/restart_button

var traits_to_display := {}

func _ready():
	restart_button.pressed.connect(_on_restart_pressed)
	
   
	await get_tree().process_frame

	if traits_to_display.size() > 0:
		display_traits()


func set_traits(collected_traits: Dictionary) -> void:
	traits_to_display = collected_traits

func display_traits() -> void:
	print("Received traits:", traits_to_display)

   
	var trait_text := ""
	for t in traits_to_display.keys():
		trait_text += "• %s\n" % t
	trait_list.text = trait_text.strip_edges()

   
	name_label.text = generate_name(traits_to_display)
	blurb_label.text = generate_blurb(traits_to_display)

func generate_name(traits: Dictionary) -> String:
	if traits.has("glow") and traits.has("bright_palette"):
		return "Sunwing"
	elif traits.has("frayed_edges") and traits.has("pastel_palette"):
		return "Paperflor"
	elif traits.has("neutral_palette"):
		return "Neuluna"
	else:
		return "Unnamed Moth"

func generate_blurb(traits: Dictionary) -> String:
	if traits.has("fuzzy"):
		return "This moth spends long days flying higher than average. It is said that it wishes to be a bird."
	elif traits.has("torn_wing"):
		return "Even damaged wings can carry great strength. This one proves it."
	elif traits.has("bold_pattern"):
		return "This moth finds strengh in a bold world. It is said it gets bolder with age."
	else:
		return "A mysterious presence, fluttering between what is seen and unseen."

func _on_restart_pressed():
	get_tree().reload_current_scene()
