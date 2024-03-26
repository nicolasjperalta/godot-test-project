class_name Inventory
extends Node

@export var items : Array[ItemData] = []
@onready var map_items = get_parent().get_parent().get_node("map_items")
@onready var player = get_parent()

signal item_picked_up

func findItemByType(itemType : String) -> ItemData:
    for item in items:
        if item.type == itemType:
            return item
    return null

func add_item(item : ItemData):
    var found = findItemByType(item.type)

    if found and found.type != "generic":
        items.erase(found)
        map_items.spawn_item(found, player.position + Vector2(40,0))
        
    items.append(item)
    emit_signal("item_picked_up", item)


func remove_item(item : ItemData):
    items.erase(item)
    
func pop_item() -> ItemData:
    var item = items[0]
    items.remove_at(0)
    return item

func get_items() -> Array[ItemData]:
    return items

func get_health() -> int:
    var total = 0
    for item in items:
        total += item.health
    return total

func get_attack() -> int:
    var total = 0
    for item in items:
        total += item.attack
    return total

func get_weight() -> int:
    var total = 0
    for item in items:
        total += item.weight
    return total
