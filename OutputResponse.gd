extends RichTextLabel

onready var tween = $Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	animate_text()
	pass # Replace with function body.

func animate_text() -> void:
	var characters = bbcode_text.length()
	print(characters)
	var time = float(characters) / 80.0
	print(time)
	tween.interpolate_property(self,"percent_visible", 0 , 1 , time)
	tween.start()
