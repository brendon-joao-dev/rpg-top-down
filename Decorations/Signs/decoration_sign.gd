extends DecorationComponent
class_name DecorationSign

func _ready() -> void:
	var _sign_texture: String = _textures_list.pick_random()
	if _sign_texture == "res://Decorations/Signs/18.png":
		$Textura1.position = Vector2(-64, -128)
	
	$Textura1.texture = load(_sign_texture)
