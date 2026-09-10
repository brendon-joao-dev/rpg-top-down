extends StaticBody2D
class_name PhysicsTree

const _WOOD_COLLECTABLE: PackedScene = preload("res://Collectables/wood.tscn")

var _is_dead: bool = false

@export_category("Variables")
@export var _health: int
@export var _min_health: int = 10
@export var _max_health: int = 30
@export var _min_wood: int = 1
@export var _max_wood: int = 5

@export_category("Objects")
@export var _animation: AnimationPlayer

func _ready() -> void:
	_health = randi_range(_min_health, _max_health)

func update_health(_damage_range: Array) -> void: # [1, 5]
	if _is_dead:
		return
	
	_health -= randi_range(_damage_range[0], _damage_range[1])
	
	if _health <= 0:
		_spawn_wood()
		_is_dead = true
		_animation.play("kill")
		return
	
	_animation.play("hit")

func _spawn_wood() -> void:
	var _wood_amount: int = randi_range(_min_wood, _max_wood)
	for _i in _wood_amount:
		var _wood: CollectableComponent = _WOOD_COLLECTABLE.instantiate()
		_wood.global_position = global_position + Vector2(randi_range(-32, 32), randi_range(-32, 32))
		get_tree().root.call_deferred("add_child", _wood)

func _on_animation_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "hit":
		_animation.play("idle")
