extends CharacterBody2D
class_name BaseCharacter
@export_category("Variables")
@export var _move_speed: float = 128.0

@export_category("Objects")
@export var _sprite2D: Sprite2D
@export var _animation: AnimationPlayer

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var _direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	velocity = _direction * _move_speed
	move_and_slide()
	
	if velocity.x > 0:
		_sprite2D.flip_h = false
		
	if velocity.x < 0:
		_sprite2D.flip_h = true
		
	if velocity:
		_animation.play("run")
		return
		
	_animation.play("idle")
	
	print(_direction)
	print(_direction.length())
	pass
