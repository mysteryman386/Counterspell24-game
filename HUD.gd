extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageBacking.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$MessageLabel.text = "Play Again?"
	$MessageLabel.show()
	$MessageBacking.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)

func update_lives(lives):
	if lives == 0:
		$heart1.show()
		$heart2.show()
		
	if lives == 1:
		$heart1.hide()
		$heart2.show()
	if lives == 2:
		$heart1.hide()
		$heart2.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	
	start_game.emit()


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	$MessageBacking.hide()

func _ready():
	$heart1.hide()
	$heart2.hide()
