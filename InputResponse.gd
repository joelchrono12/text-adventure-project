extends VBoxContainer

onready var input_history = $InputHistory
onready var output_response = $OutputResponse
onready var anim_player = $AnimationPlayer
onready var tween = $Tween
var characters

func _ready() -> void:

	pass

func set_text(input: String, response: String):
	input_history.text = input
	output_response.bbcode_text = response
	output_response.animate_text()
