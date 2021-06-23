extends Node


func _ready():
	var key = Item.new()
	var knife = Item.new()
	var screwdriver = Item.new()
	var crank = Item.new()
	var note = Item.new()
	var cuchara = Item.new()
	var ring = Item.new()
	var grifo = Item.new()
	var mainkey = Item.new()

	key.initialize("llave", Types.ItemTypes.KEY)
	knife.initialize("cuchillo", Types.ItemTypes.KEY)
	note.initialize("nota",Types.ItemTypes.KEY)
	screwdriver.initialize("desarmador",Types.ItemTypes.KEY)
	cuchara.initialize("cuchara",Types.ItemTypes.KEY)
	mainkey.initialize("llave",Types.ItemTypes.KEY)
	crank.initialize("palanca",Types.ItemTypes.KEY)


	$Sala.connect_exit_unlocked("norte", $Pasillo)
	$Sala.connect_exit_locked("sur", $ParkingLot)
	$Sala.connect_exit_unlocked("este", $Comedor)
	$Sala.connect_exit_unlocked("oeste",$Bathroom)
	$Pasillo.connect_exit_unlocked("oeste",$Habitacion)
	$Pasillo.connect_exit_locked("norte",$HabitacionGrande)
	$Habitacion.connect_exit_unlocked("sur",$Bathroom)
	$HabitacionGrande.connect_exit_locked("oeste",$BigBath)
	$HabitacionGrande.connect_exit_locked("este",$Ropero)
	$Ropero.connect_exit_locked("norte",$SecretRoom)
	$SecretRoom.connect_exit_unlocked("oeste",$PasilloSecreto)
	$Comedor.connect_exit_unlocked("norte",$Cocina)
	$Comedor.connect_exit_unlocked("sur",$Invernadero)
	$Invernadero.connect_exit_locked("este",$Bodega)
	$PasilloSecreto.connect_exit_unlocked("sur",$BigBath)
	$ParkingLot.connect_exit_unlocked("sur",$Fin)

	knife.use_value = $Ropero
	key.use_value = $Bodega
	screwdriver.use_value = $SecretRoom
	note.use_value = $HabitacionGrande
	mainkey.use_value = $ParkingLot
	crank.use_value = $BigBath

	$BigBath.add_item(mainkey)
	$SecretRoom.add_item(crank)
	$Bathroom.add_item(key)
	$Habitacion.add_item(note)
	$Bodega.add_item(screwdriver)
	$Cocina.add_item(knife)
	$Comedor.add_item(cuchara)
