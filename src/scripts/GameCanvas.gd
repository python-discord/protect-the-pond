extends CanvasLayer

var denied = false
var ducks = 0


func _ready():
	$DuckCounter.text = str(ducks)


func _on_Allow_pressed():
	if $River.get_child_count():
		var ducky = $River.get_child(0)
		if ducky.unit_offset > 0.5:
			ducky.to_pondhouse()


func _on_Deny_pressed():
	if $River.get_child_count() and !denied:
		denied = true
		var ducky = $River.get_child(0)
		ducky.get_child(0).get_node("Boom").show()
		yield(get_tree().create_timer(.5), "timeout")
		ducky.queue_free()
		ducks -= 1
		$DuckCounter.text = str(ducks)
		denied = false


func _on_add_duck():
	ducks += 1
	$DuckCounter.text = str(ducks)
