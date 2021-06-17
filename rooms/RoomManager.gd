extends Node


func _ready():
	var key = Item.new()
	key.initialize("llave", Types.ItemTypes.KEY)
	key.use_value = $Bodega
	$Sala.connect_exit_unlocked("este", $Patio)
	$Patio.add_item(key)
	$Patio.connect_exit_locked("norte", $Bodega)
