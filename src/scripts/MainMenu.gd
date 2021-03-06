extends CanvasLayer
signal new_game
var sound_played = false


func _on_Button_mouse_entered():
	if !sound_played:
		sound_played = true
		$Plop.play()


func _on_Button_mouse_exited():
	sound_played = false
	$Plop.stop()


func hide_canvas():
	$Background.hide()
	$Buttons.hide()


func _on_NewGame_pressed():
	emit_signal('new_game')


func _on_Exit_pressed():
	get_tree().quit()
