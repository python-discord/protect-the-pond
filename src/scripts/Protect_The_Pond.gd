extends Node
export (PackedScene) var gamenode


func _on_MainMenu_new_game():
	$MainMenu.hide_canvas()
	var game = gamenode.instance()
	add_child(game)
