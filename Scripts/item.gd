extends Area2D

@export var itemData : ItemData
@onready var sprite = $sprite
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.region_rect = itemData.spriteRec
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print(body)
	body.get_node("Inventory").add_item(itemData)
	queue_free()
