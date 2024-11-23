extends RigidBody2D

#func _ready():
#	pass

#extends Area2D # Make sure this matches your node type

@export var speed = 200 # Speed of the mob
var player = null # Reference to the player

func _ready():
	# Find the player in the scene (adjust the path as needed)
	add_to_group("Mobs")
	player = get_node("/root/Main/Player")
	if not player:
		print("Player node not found! Check the path.")

func _process(delta):
	if player:
		# Calculate the direction to the player
		var direction = (player.position - position).normalized()
		
		# Move towards the player
		position += direction * speed * delta
		
		# Rotate the mob to face the player
		rotation = direction.angle()
