extends Node


func _ready():
	$MenuPrincipal.connect_exit_unlocked("este", $Creditos)

