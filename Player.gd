extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var zeroLives = true

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	print("Node path: ", get_path())



func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if zeroLives == false:
		if Input.is_action_pressed("move_right"):
			$Sprite2D.hide()
			$left.hide()
			$right.show()
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			$Sprite2D.hide()
			$right.hide()
			$left.show()
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			$right.hide()
			$left.hide()
			$Sprite2D.show()
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			$right.hide()
			$left.hide()
			$Sprite2D.show()
			velocity.y -= 1

	# Normalize velocity for diagonal movement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2(200, 237), Vector2(3100,2800))
	
	

	if velocity.x != 0:
		$Sprite2D.flip_v = false
		$Trail.rotation = 0
		$Sprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		rotation = PI if velocity.y > 0 else 0

	# Ensure the TextureRect stays at the origin relative to Area2D
	$Sprite2D.position = Vector2.ZERO


func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(_body):
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.

func zero_Lives():
	hide() # Player disappears after being hit.
	$CollisionShape2D.set_deferred("disabled", true)
	zeroLives = true

func add_Lives():
	zeroLives = false
