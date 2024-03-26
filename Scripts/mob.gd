extends CharacterBody2D

@export var mobData : MobData
@onready var healthLabel = $HealthLabel
var timer;
var sprite;
var health;
func _ready():
	timer = $Timer
	sprite = $Mobs
	health = mobData.health
	sprite.region_rect = mobData.spriteRec
	pass

	
func flash():
	sprite.material.set_shader_parameter("flash_modifier", 1.0)
	timer.start()
	pass

func take_damage(damage):
	flash()
	
	health -= damage
	print(health)
	healthLabel.text = "%d" % health
	healthLabel.visible = true
	if health <= 0:
		queue_free()

func _physics_process(delta):
	pass



func _on_timer_timeout():
	sprite.material.set_shader_parameter("flash_modifier", 0)
	healthLabel.visible = false
	pass # Replace with function body.
