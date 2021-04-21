extends CanvasLayer
var sound_played = false
signal new_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Button_mouse_entered():
	
	if !sound_played:
		sound_played = true
		$Plop.play()


func _on_Button_mouse_exited():
	sound_played = false
	$Plop.stop()


func _hide_canvas():
	$Background.hide()
	$NewGame.hide()
	$HighScore.hide()
	$Exit.hide()


func _on_NewGame_pressed():
	emit_signal('new_game')
