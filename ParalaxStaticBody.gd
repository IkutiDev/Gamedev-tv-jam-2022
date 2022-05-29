extends StaticBody2D



func _ready():
	var target_layer = get_parent().get_parent().get_node("ParallaxBackground")
	Physics2DServer.body_set_space(get_rid(), target_layer.get_world_2d().get_space())
