extends ParallaxBackground

func _process(delta):
	for layer in get_children():
		if layer is ParallaxLayer:
			var offset = layer.offset.x
			if offset < -layer.texture.get_size().x:
				layer.offset.x += layer.texture.get_size().x * 2
