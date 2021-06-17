extends Node


func _ready():
	$"Menu Principal".connect_exits("este", $"Casa Inicial")
