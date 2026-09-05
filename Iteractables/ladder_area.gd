extends Area2D
class_name LadderArea

@onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
# Usar $nome_nó é o mesmo que o get_node acima

func _on_body_exited(_body: Node2D) -> void:
	if _body is BaseCharacter:
		if  collision_shape.global_position.y > _body.global_position.y:
			_body.update_mountain_state(true)
			print("Lá no alto")
		if collision_shape.global_position.y < _body.global_position.y:
			_body.update_mountain_state(false)
			print("Cá em baixo")
		pass
