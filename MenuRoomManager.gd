extends Node


func _ready():
	$MenuPrincipal.connect_exit_unlocked("este", $Creditos)
	$MenuPrincipal.connect_exit_unlocked("oeste", $Documentacion)

