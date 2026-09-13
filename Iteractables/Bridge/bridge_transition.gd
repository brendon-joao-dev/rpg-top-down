extends Area2D
class_name BridgeTransition

@onready var collision_shape: CollisionShape2D = get_node("Collision")
# Usar $nome_nó é o mesmo que o get_node acima

@export_category("Variables")
@export var _bridge_orietation: bool = false # true = vertical; false = horizontal; 
@export var _bridge_is_reverse: bool = false # true = voltando; false = indo;

func _on_body_exited(_body: Node2D) -> void:
	if _body is BaseCharacter:
		# ponte vertical
		if _bridge_orietation == true:
			# indo
			if _bridge_is_reverse == false:
				if _body.global_position.y > collision_shape.global_position.y:
					_body.update_bridge_state(true)
					
				if _body.global_position.y < collision_shape.global_position.y:
					_body.update_bridge_state(false)
			
			# voltando
			if _bridge_is_reverse == true:
				pass
			pass
			
		# ponte horizontal
		if _bridge_orietation == false:
			# indo
			if _bridge_is_reverse == false:
				pass
			
			# voltando
			if _bridge_is_reverse == true:
				pass
			pass
			

			#if  collision_shape.global_position.y < _body.global_position.y:
				#_body.update_bridge_state(true)
			#if collision_shape.global_position.y > _body.global_position.y:
				#_body.update_bridge_state(false)
				#
			#if  collision_shape.global_position.y > _body.global_position.y:
				#_body.update_bridge_state(true)
			#if collision_shape.global_position.y < _body.global_position.y:
				#_body.update_bridge_state(false)

func _on_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_body.update_bridge_state(true)
