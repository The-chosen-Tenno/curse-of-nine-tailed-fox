extends Area2D

@onready var game_manager: Node = %GameManager

func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	game_manager.addSpirit()
	queue_free()
