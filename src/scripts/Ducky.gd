extends PathFollow2D

signal river_end
signal teller_end

export (Array, Texture) var hats
export (Array, Texture) var equips

export var river_speed = 40
export var php_speed = 75
export var pond_speed = 60
export var flap_degree = 360
export var bob_values = [-15, 15]

var hat
var equipment

onready var rigidbody = self.get_child(0)

func _ready():
	set_physics_process(true)
	randomize()
	hat = hats[randi() % hats.size()]
	equipment = equips[randi() % equips.size()]
	$Ducky/Hat.texture = hat
	$Ducky/Equipment.texture = equipment
	$Ducky/Hat.show()
	$Ducky/Equipment.show()
	var random_color = Color(randf(), randf(), randf())
	$Ducky/Light.color = random_color.inverted()
	$Ducky/Body.color = random_color
	$Ducky/Wing.color = random_color
	$Ducky/Beak.color = random_color.inverted()
	$Ducky/Eye.color = random_color.darkened(.2)
	$Ducky/WingEye.color = random_color.darkened(.2)
	bob_tween_start()


func get_speed():
	var location = get_parent().name
	var speed
	if location == 'River':
		speed = river_speed
	elif location == 'PondHousePath':
		speed = php_speed
	elif location == 'Pond':
		speed = pond_speed
	return [speed, location]


func _physics_process(delta):
	var speed_location = get_speed()
	var speed = speed_location[0]
	var location = speed_location[1]
	self.set_offset(self.get_offset() + (speed*delta))
	if location == 'River' and self.unit_offset == 1:
		emit_signal('river_end')
		to_pondhouse()
	elif location == 'PondHousePath' and self.unit_offset == 1:
		emit_signal('teller_end')
		to_pond()
	elif location == 'Pond':
		$Duck/body.rotation_degrees += 30 * delta * randf()
	$Duck/body/wing.rotation_degrees += flap_degree * delta * randf()
	$Duck/body/tail.position += Vector2(delta*rand_range(-5,5), delta*rand_range(-5,5))


func to_pondhouse():
	var pondhouse = self.get_parent().get_parent().get_node('PondHousePath')
	get_parent().remove_child(self)
	self.scale *= Vector2(7,7)
	self.rotation_degrees = 0
	self.set_offset(0)
	self.rotate = false
	pondhouse.add_child(self)


func to_pond():
	var pond = self.get_parent().get_parent().get_node('Pond')
	get_parent().remove_child(self)
	self.scale = Vector2(1,1)
	self.rotate = true
	self.loop = true
	pond.add_child(self)


func bob_tween_start():
	$Bob.interpolate_property($Duck/body/head, "rotation_degrees", bob_values[0], bob_values[1], 1,
		Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Bob.start()


func _on_Bob_tween_completed(_object, _key):
	bob_values.invert()
	bob_tween_start()
