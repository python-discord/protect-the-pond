extends Node
export (PackedScene) var Game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_MainMenu_new_game():
	$MainMenu._hide_canvas()
	var game = Game.instance()
	add_child(game)
