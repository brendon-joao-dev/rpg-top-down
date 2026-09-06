extends Node2D
class_name DecorationComponent

@export_category("Variables")
@export var _textures_list: Array[String]

func _ready() -> void:
	for _children in get_children():
		if _children is Sprite2D:
			_children.texture = load(
				_textures_list.pick_random()
			)
