extends VBoxContainer

onready var input = $InputHistory
onready var response = $OutputResponse
onready var anim_player = $AnimationPlayer
onready var tween = $Tween
var characters

func _ready() -> void:
	pass
func _start() -> void:
	characters = response.bbcode_text.length()
	print(characters)
	var time = float(characters) / 80.0
	print(time)
	tween.interpolate_property(response,"percent_visible", 0 , 1 , time)
	tween.start()
