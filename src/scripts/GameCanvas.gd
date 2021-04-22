extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.hide()
	$Exit.hide()


func _on_Allow_pressed():
	if $River.get_child_count():
		var ducky = $River.get_child(0)
		if ducky.get_offset() > 500:
			$River.remove_child(ducky)
			ducky.loop = true
			$Pond.add_child(ducky)


func _on_Deny_pressed():
	if $River.get_child_count():
		var ducky = $River.get_child(0)
		ducky.queue_free()
