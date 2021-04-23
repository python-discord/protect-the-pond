extends PathFollow2D

signal river_end
signal teller_end

 
export var ducky_hat  = preload("res://assets/duck-builder/accessories/hats/beret.png")
export var river_speed = 40
export var php_speed = 75
export var pond_speed = 60

var hat


# Called when the node enters the scene tree for the first time.
func _init():
	set_physics_process(true)
	hat = TextureRect.new()
	hat.texture = ducky_hat


func _ready():
	randomize()
	$Ducky.add_child(hat)

func get_speed():
	var location = get_parent().name
	if location == 'River':
		return river_speed
	elif location == 'PondHousePath':
		return php_speed
	elif location == 'Pond':
		return pond_speed


func _physics_process(delta):
	var speed = get_speed()
	self.set_offset(self.get_offset() + (speed*delta))

	if get_parent().name == 'River' and self.unit_offset == 1:
		emit_signal('river_end')
		to_pondhouse()
	elif get_parent().name == 'PondHousePath' and self.unit_offset == 1:
		emit_signal('teller_end')
		to_pond()


func to_pondhouse():
	var pondhouse = self.get_parent().get_parent().get_node('PondHousePath')
	get_parent().remove_child(self)
	self.scale = Vector2(7,7)
	self.rotation_degrees = 0
	self.set_offset(0)
	self.rotate = false
	pondhouse.add_child(self)


func to_pond():
	var pond = self.get_parent().get_parent().get_node('Pond')
	get_parent().remove_child(self)
	self.scale = Vector2(1,1)
	self.rotation_degrees = 0
	self.rotate = true
	self.loop = true
	pond.add_child(self)
