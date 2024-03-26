extends Node

@onready var chestSprite = $chest
@onready var weaponSprite = $weapon
@onready var headSprite = $head


func _on_inventory_item_picked_up(itemData : ItemData):
	match itemData.type:
		"chest":
			chestSprite.region_rect = itemData.spriteRec
			chestSprite.position = itemData.spritePosition
			chestSprite.visible = true
		"weapon":
			weaponSprite.region_rect = itemData.spriteRec
			weaponSprite.position = itemData.spritePosition
			weaponSprite.visible = true
		"head":
			headSprite.region_rect = itemData.spriteRec
			headSprite.position = itemData.spritePosition
			headSprite.visible = true
			
			
	pass # Replace with function body.


func _on_inventory_item_dropped(ItemData, pos):
	match ItemData.type:
		"chest":
			chestSprite.visible = false
		"weapon":
			weaponSprite.visible = false
		"head":
			headSprite.visible = false

	pass # Replace with function body.
