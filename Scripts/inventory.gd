class_name Inventory
extends Node


class InventorySlot:
	var item : ItemData
	var count : int
	var equiped : bool

var slots : Array[InventorySlot] = []
@onready var player = get_parent()

signal item_picked_up
signal item_dropped(ItemData: ItemData, pos: Vector2)


func getSlotByType(type : String) -> InventorySlot:
	for slot in slots:
		if slot.item.type == type:
			return slot
	return null


func add_item(itemData : ItemData):
	var slot = getSlotByType(itemData.type)
	if slot != null and slot.count < slot.item.stackSize:
		remove_item(slot.item)
	else:
		slots.append(InventorySlot.new())
		slots[-1].item = itemData
		slots[-1].count = 1
	emit_signal("item_picked_up", itemData)


func remove_item(itemData : ItemData):
	var slot = getSlotByType(itemData.type)
	if slot != null:
		if slot.count > 1:
			slot.count -= 1
		else:
			slots.erase(slot)
	emit_signal("item_dropped", itemData, player.position)

func get_health() -> int:
	var health = 0
	for slot in slots:
		health += slot.item.health
	return health

func get_attack() -> int:
	var attack = 0
	for slot in slots:
		attack += slot.item.attack
	return attack

func get_armor() -> int:
	var armor = 0
	for slot in slots:
		armor += slot.item.armor
	return armor


func get_item_count(itemData : ItemData) -> int:
	var slot = getSlotByType(itemData.type)
	if slot != null:
		return slot.count
	return 0

func get_item_count_by_type(type : String) -> int:
	var count = 0
	for slot in slots:
		if slot.item.type == type:
			count += slot.count
	return count

func drop_last_item():
	if slots.size() == 0:
		return

	remove_item(slots[-1].item)
