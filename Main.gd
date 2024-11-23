extends Node

@export var mob_scene: PackedScene
var score
var lives


func game_over():
	lives -= 1
	if lives == 1:
		$ouch.play()
	if lives == 0:

		$soundtrack.stop()
		$yodaDeath.play()
		$ScoreTimer.stop()
		$MobTimer.stop()
		$HUD.show_game_over()
		$Player.zero_Lives()
		
		$DSDelay.start()
		var mobs = get_tree().get_nodes_in_group("Mobs")
		for mob in mobs:
				mob.queue_free() # Remove the mob from the scene
		
		

	



func new_game():
	lives = 2
	get_tree().call_group(&"mobs", &"queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Join your\nFriends")
	$Player.add_Lives()
	$DeathSound.stop()
	$soundtrack.play()



func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node(^"MobPath/MobSpawnLocation")
	mob_spawn_location.progress = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _process(delta):
	$HUD.update_lives(lives)
	$Player/Camera2D.addShake()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_soundtrack_finished() -> void:
	$soundtrack.stop()
	$soundtrack.play()
	pass # Replace with function body.


func _on_ds_delay_timeout() -> void:
	$DeathSound.play()
	pass # Replace with function body.
