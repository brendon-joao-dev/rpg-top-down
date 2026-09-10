extends CharacterBody2D
class_name Sheep

var _wait_time: float
var _direction: Vector2

@export_category("Variables")
@export var _move_speed: float = 128.0

@export_category("Objects")
@export var _sprite: Sprite2D
@export var _animation: AnimationPlayer
@export var _walk_timer: Timer

func _ready() -> void:
	_wait_time = randf_range(5.0, 15.0)
	_direction = _get_direction()
	_walk_timer.start(_wait_time)

func _physics_process(delta: float) -> void:
	velocity = _direction * _move_speed
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		_direction = velocity.bounce(
			get_slide_collision(0).get_normal()
		).normalized()
	
	_animate()

func _animate() -> void:
	if velocity.x > 0:
		_sprite.flip_h = false
		
	if velocity.x < 0:
		_sprite.flip_h = true
		
	if velocity:
		_animation.play("walk")
		return
	
	_animation.play("idle")

func _get_direction() -> Vector2:
	return [
		Vector2(-1, 0),  # esquerda
		Vector2(1, 0),   # direita
		Vector2(-1, -1), # esquerda-cima
		Vector2(0, -1),  # cima
		Vector2(1, -1),  # direita-cima
		Vector2(-1, 1),  # esquerda-baixo
		Vector2(0, 1),   # baixo
		Vector2(1, 1),   # direita-baixo
		Vector2.ZERO
	].pick_random().normalized()

func _on_walk_timer_timeout() -> void:
	_walk_timer.start(_wait_time)
	print(_wait_time)
	print(_direction)
	if _direction == Vector2.ZERO:
		_direction = _get_direction()
		return
	
	_direction = Vector2.ZERO
