extends Node2D

@onready var player = $Player

func _ready():
    player.get_node("Inventory").connect("item_dropped",spawn_item)

func spawn_item(item : ItemData, pos : Vector2):
    var item_node = preload("res://Scenes/item.tscn").instantiate()
    item_node.itemData = item
    item_node.position = pos + Vector2(50,0)
    get_node("map_items").add_child(item_node)

    
