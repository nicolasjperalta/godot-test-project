extends CharacterBody2D

@export var mobData : MobData
@onready var healthLabel = $HealthLabel
@onready var timer = $Timer;
@onready var sprite = $Mobs;
@onready var tilemap = get_node("../../TileMap")
@onready var player = get_node("../../Player")

var health;
var aStarGrid : AStarGrid2D
var seePlayer = false
var canAttack = true
var attackTimer = 0
var attackRate = 10
var playerInRange = false

func _ready():
    aStarGrid = AStarGrid2D.new()
    aStarGrid.region = tilemap.get_used_rect()
    aStarGrid.cell_size = Vector2(16, 16)
    aStarGrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
    aStarGrid.update()

    health = mobData.health
    sprite.region_rect = mobData.spriteRec

func flash():
    sprite.material.set_shader_parameter("flash_modifier", 1.0)
    timer.start()

func take_damage(damage):
    flash()
    health -= damage

    healthLabel.text = "%d" % health
    healthLabel.visible = true
    if health <= 0:
        queue_free()

func _physics_process(delta):
    if seePlayer:
        var id_path = aStarGrid.get_id_path(tilemap.local_to_map(player.position), tilemap.local_to_map(position))
        if id_path.is_empty():
            return

        var target_position = tilemap.map_to_local(id_path[1])

        global_position = global_position.move_toward(target_position, 1)
        if global_position == target_position:
            id_path.pop_front()
    
    if !canAttack:
        if attackTimer >= 0:
            attackTimer -= 1
        else:
            canAttack = true
            attackTimer = attackRate
    # TODO: Refactor player node this sucks
    elif playerInRange and player.get_node("Camera2D"):
        canAttack = false
        player.get_node("Camera2D").take_damage(mobData.attackDamage)

func _on_timer_timeout():
    sprite.material.set_shader_parameter("flash_modifier", 0)
    healthLabel.visible = false

func _on_sight_body_entered(body):
    if body == player:
        seePlayer = true

func _on_sight_body_exited(body):
    if body == player:
        seePlayer = false

func _on_attack_range_body_entered(body):
    playerInRange = true

func _on_attack_range_body_exited(body):
    playerInRange = false

