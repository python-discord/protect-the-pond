extends Skeleton2D

var bob_values = [-10, 10]
var previous_color = Color(0,0,0)


func _ready():
	bob_tween_start()
	_color_change()


func _physics_process(delta):
	randomize()
	if !Engine.editor_hint:
		return
	$body/wing.rotation_degrees += 180 * delta * randf()
	$body/tail.position += Vector2(delta*rand_range(-5,5), delta*rand_range(-5,5))
	$body/head/top.position += Vector2(delta*rand_range(-5,5), delta*rand_range(-1,1))
	$body/head/bottom.position += Vector2(delta*rand_range(-5,5), delta*rand_range(-1,1))


func _color_change():
	var random_color = Color(randf(), randf(), randf())
	var body = get_parent().get_node('Ducky/Body')
	$color.interpolate_property(body, "color", previous_color, random_color, 5,
		Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$color.start()
	previous_color = random_color


func bob_tween_start():
	$test_bob.interpolate_property($body/head, "rotation_degrees", bob_values[0], bob_values[1], 5,
		Tween.TRANS_CUBIC, Tween.EASE_IN)
	$test_bob.start()


func _on_test_bob_tween_completed(_object, _key):
	bob_values.invert()
	bob_tween_start()


func _on_color_completed(_object, _key):
	_color_change()


func _on_Ducky_mouse_entered():
	print('entered')
	$body/head.rotation_degrees -= 10


func _on_Ducky_mouse_exited():
	print('exited')
	$body/head.rotation_degrees += 10
