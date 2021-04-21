extends Node
export (PackedScene) var gamenode


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_MainMenu_new_game():
	$MainMenu.hide_canvas()
	var game = gamenode.instance()
	add_child(game)
