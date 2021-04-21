extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.hide()
	$Exit.hide()


func _on_Allow_pressed():
	if $River.get_child_count():
		var ducky = $River.get_child(0)
		$River.remove_child(ducky)
		$Pond.add_child(ducky)
