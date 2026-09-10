extends StaticBody2D
class_name GoldMine

const _GOLD_COLLECTABLE: PackedScene = preload("res://Collectables/gold.tscn")

var _character_ref: BaseCharacter = null

var _current_production_timer: float = 0.0

var _mine_level: int = 0
var _mine_data: Dictionary = {
	0: {
		"texture": "res://Resources/Gold Mine/GoldMine_Destroyed.png",
		"item_required": {
			"item_name": "wood",
			"item_amount": 10
		}
	},
	1: {
		"texture": "res://Resources/Gold Mine/GoldMine_Inactive.png",
		"item_required": {
			"item_name": "wood",
			"item_amount": 25
		}
	},
	2: {
		"texture": "res://Resources/Gold Mine/GoldMine_Active.png",
		"item_required": {
			"item_name": "wood",
			"item_amount": 5
		}
	}
}

@export_category("Variables")
@export var _default_production_time: float = 10.0
@export var _additional_production_time: float = 15.0

@export_category("Objects")
@export var _sprit2D: Sprite2D
@export var _production_timer: Timer

func _on_gold_mine_area_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_character_ref = _body

func _on_gold_mine_area_body_exited(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_character_ref = null

func _process(_delta:float) -> void:
	if Input.is_action_just_pressed("interact") and _character_ref != null:
		var _item_data: Dictionary = _mine_data[_mine_level]["item_required"]
		if _character_ref.has_resource(_item_data["item_name"], _item_data["item_amount"]):
			_mine_level += 1
			
			if _mine_level == 2:
				_production_timer.start(_default_production_time)
				
			if _mine_level >= 3:
				_current_production_timer = _production_timer.time_left + _additional_production_time
				_production_timer.start(_current_production_timer)
				_mine_level = 2
			
			_sprit2D.texture = load(_mine_data[_mine_level]["texture"])

func _on_production_timer_timeout() -> void:
	_mine_level = 1
	_sprit2D.texture = load(_mine_data[_mine_level]["texture"])
	_current_production_timer = 0

func _on_spawn_timer_timeout() -> void:
	if _mine_level < 2:
		return
	
	var _gold:  CollectableComponent = _GOLD_COLLECTABLE.instantiate()
	get_tree().root.call_deferred("add_child", _gold)
	_gold.global_position = global_position + Vector2(
		randi_range(-96, 96),
		randi_range(64, 96)
	)
