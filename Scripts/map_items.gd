extends Node2D

func spawn_item(item : ItemData, pos : Vector2):
    var item_node = preload("res://Scenes/item.tscn").instantiate()
    item_node.itemData = item
    item_node.position = pos
    add_child(item_node)
    
