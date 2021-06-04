extends Sprite

var forward = true
var speed = 50
onready var river = get_node("../VpC/Vp/Game/River")
onready var path = get_node('..')


func _physics_process(delta):
	if forward:
		region_rect.position += Vector2(1,0) * delta * 10
		if region_rect.position[0] >= 1280 - region_rect.size[0]:
			forward = false
	else:
		region_rect.position -= Vector2(1,0) * delta * 10
		if region_rect.position[0] <= 930:
			forward = true
