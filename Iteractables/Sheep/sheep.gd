extends CharacterBody2D
class_name Sheep

const _MEAT_COLLECTABLE: PackedScene = preload("res://Collectables/meat.tscn")

var _is_dead: bool = false
var _health: int
var _wait_time: float
var _run_wait_time: float
var _direction: Vector2
var _regular_move_speed: float

@export_category("Variables")
@export var _move_speed: float = 128.0
@export var _min_health: int = 5
@export var _max_health: int = 15
@export var _min_meat: int = 1
@export var _max_meat: int = 5

@export_category("Objects")
@export var _sprite: Sprite2D
@export var _animation: AnimationPlayer
@export var _walk_timer: Timer
@export var _run_timer: Timer

func _ready() -> void:
	_regular_move_speed = _move_speed
	_health = randi_range(_min_health, _max_health)
	_wait_time = randf_range(5.0, 15.0)
	_run_wait_time = randf_range(1.0, 3.0)
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

func update_health(_damage_range: Array) -> void: # [1, 5]
	if _is_dead:
		return
	
	_health -= randi_range(_damage_range[0], _damage_range[1])
	
	if _health <= 0:
		_spawn_meat()
		_is_dead = true
		queue_free()
		return
		
	_direction = _get_direction()
	_run_timer.start(_run_wait_time)
	_move_speed *= 4

func _spawn_meat() -> void:
	var _meat_amount: int = randi_range(_min_meat, _max_meat)
	for _i in _meat_amount:
		var _meat: CollectableComponent = _MEAT_COLLECTABLE.instantiate()
		_meat.global_position = global_position + Vector2(randi_range(-32, 32), randi_range(-32, 32))
		get_tree().root.call_deferred("add_child", _meat)


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
	if _direction == Vector2.ZERO:
		_direction = _get_direction()
		return
	
	_direction = Vector2.ZERO

func _on_run_timer_timeout() -> void:
	_move_speed =  _regular_move_speed
