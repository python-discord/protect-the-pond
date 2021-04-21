extends KinematicBody2D
var set_fixed_process
var hat

func _ready():
	set_physics_process(true)
	hat = TextureRect.new()
	hat.texture = preload("res://assets/duck-builder/accessories/hats/beret.png")
	add_child(hat)

func _physics_process(delta):
	get_parent().set_offset(get_parent().get_offset() + (40*delta))  
