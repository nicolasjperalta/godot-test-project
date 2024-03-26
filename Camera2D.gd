extends Camera2D

var player_mob
# Called when the node enters the scene tree for the first time.
func _ready():
    player_mob = $".."
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var forceY = Input.get_action_strength("down") - Input.get_action_strength("up")
    var forceX = Input.get_action_strength("right") - Input.get_action_strength("left")
    var speed = 10000
    
        
    player_mob.velocity = Vector2(0,0)
    if Input.is_action_just_pressed("attack"):
        speed = 0
    else:
        if forceY != 0:
            player_mob.velocity.y = forceY * speed * delta
        elif forceX != 0:
            player_mob.velocity.x = forceX * speed * delta
        
        player_mob.move_and_slide()

