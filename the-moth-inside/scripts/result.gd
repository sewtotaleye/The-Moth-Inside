extends Control

@onready var name_label = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/name_label
@onready var blurb_label = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/blurb_label
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

   
    var moth_name = generate_name(traits_to_display)
    name_label.text = moth_name
    blurb_label.text = generate_blurb(traits_to_display)

    var path = get_moth_image_path(moth_name)
    moth_image.texture = load(path)

func generate_name(traits: Dictionary) -> String:
    if traits.has("glow") and traits.has("bright_palette") and traits.has("fuzzy"):
        return "Luna Moth"
    elif traits.has("bright_palette") and traits.has("round_wings") and traits.has("fuzzy"):
        return "Rosy Maple Moth"
    elif traits.has("bold_pattern") and traits.has("warm_palette"):
        return "Atlas Moth"
    elif traits.has("cool_palette") and traits.has("frayed_edges") and traits.has("chaotic_pattern"):
        return "Death's Head Hawkmoth"
    elif traits.has("smooth_edges") and traits.has("round_wings") and traits.has("bold_pattern"):
        return "Io Moth"
    elif traits.has("neutral_palette") and traits.has("glow") and traits.has("frayed_edges"):
        return "White Witch Moth"
    elif traits.has("red_tattoo") and traits.has("fuzzy") and traits.has("round_wings"):
        return "Cecropia Moth"
    else:
        return "Unnamed Moth"

func generate_blurb(traits: Dictionary) -> String:
    if traits.has("glow") and traits.has("bright_palette") and traits.has("fuzzy"):
        return "This luminous traveler bathes in moonlight and dreams of distant stars."
    elif traits.has("bright_palette") and traits.has("round_wings") and traits.has("fuzzy"):
        return "Vibrant and unapologetic, this moth flutters through life like a walking pastel daydream"
    elif traits.has("bold_pattern") and traits.has("warm_palette"):
        return "Wings like continents, presence like thunder. It carries ancient stories on every scale."
    elif traits.has("cool_palette") and traits.has("frayed_edges") and traits.has("chaotic_pattern"):
        return "Mysterious and misunderstood, it hums lullabies to the forgotten"
    elif traits.has("smooth_edges") and traits.has("round_wings") and traits.has("bold_pattern"):
        return "With a glance that startles and a softness that soothes, it dances between illusion and intention."
    elif traits.has("neutral_palette") and traits.has("glow") and traits.has("frayed_edges"):
        return "Its wings whisper across the night sky, tracing the arc of forgotten wishes."
    elif traits.has("red_tattoo") and traits.has("fuzzy") and traits.has("round_wings"):
        return "A flame-hearted guardian of forest twilight, it breathes warmth into silent woods."
    else:
        return "A mysterious presence, fluttering between what is seen and unseen."
        
func get_moth_image_path(name: String) -> String:
    match name:
        "Luna Moth":
            return "res://assets/moths/luna_moth.png"
        "Rosy Maple Moth":
            return "res://assets/moths/rosy_maple_moth.png"
        "Atlas Moth":
            return "res://assets/moths/atlas_moth.png"
        "Death's Head Hawkmoth":
            return "res://assets/moths/deaths_head_hawkmoth.png"
        "Io Moth":
            return "res://assets/moths/io_moth.png"
        "White Witch Moth":
            return "res://assets/moths/white_witch_moth.png"
        "Cecropia Moth":
            return "res://assets/moths/cecropia_moth.png"
        _:
            return "res://assets/moths/unnamed_moth.png"

func _on_restart_pressed():
    get_tree().reload_current_scene()
