extends Area2D
class_name CollectableComponent


func _on_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		queue_free()
		#_body.add_item({
			#"item_name": "wood",
			#"item_amount": [1, 5],
			#"item_texture": "res://Resources/Resources/W_Idle.png"
			#})
