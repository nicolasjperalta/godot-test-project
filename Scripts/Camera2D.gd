extends Camera2D

@onready var player_mob = $".."
@onready var raycast = $"../RayCast2D"
@onready var inventory : Inventory = $"../Inventory"
var health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var forceY = Input.get_action_strength("down") - Input.get_action_strength("up")
	var forceX = Input.get_action_strength("right") - Input.get_action_strength("left")
	var speed = 10000        
	player_mob.velocity = Vector2(0,0)
	
	if Input.is_action_pressed("down"):
		raycast.target_position = Vector2.DOWN * 35
	elif Input.is_action_pressed("up"):
		raycast.target_position = Vector2.UP * 35
	elif Input.is_action_pressed("left"):
		raycast.target_position = Vector2.LEFT * 35
	elif Input.is_action_pressed("right"):
		raycast.target_position = Vector2.RIGHT * 35

	if Input.is_action_pressed("attack"):
		speed = 0
		if Input.is_action_just_pressed("attack"):
			_attack()    

	if Input.is_action_just_pressed("use"):
		inventory.drop_last_item()

	if forceY != 0:
		player_mob.velocity.y = forceY * speed * delta
	elif forceX != 0:
		player_mob.velocity.x = forceX * speed * delta
		
	player_mob.move_and_slide()
	

func _attack():
	# check if raycast is colliding with body and if its mob call take damage
	
	if raycast.is_colliding():
		if raycast.get_collider().is_in_group("mobs"):
			raycast.get_collider().take_damage(inventory.get_attack())

func take_damage(damage):
	health -= damage
	print(damage)
	if health <= 0:
		queue_free()
