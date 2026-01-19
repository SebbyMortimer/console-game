extends Control

var gameNode = preload("res://gameNode.tscn")

var games = [
	{
		gameName = "Flynn's Shenanigans",
		image = "icon.svg",
	},
	{
		gameName = "Idk",
		image = "icon.svg",
	},
	{
		gameName = "Yes why not",
		image = "icon.svg",
	},
	{
		gameName = "Another game",
		image = "icon.svg",
	},
	{
		gameName = "Ok this list is starting to get pretty long",
		image = "icon.svg",
	},
	{
		gameName = "Supercalifragilisticexpialidocious",
		image = "icon.svg",
	},
	{
		gameName = "One more for good measure",
		image = "icon.svg",
	},
]

var current_game = 1


func _ready() -> void:
	var count = 1
	for game in games:
		var newGameNode = gameNode.instantiate()
		newGameNode.name = str(count)
		newGameNode.get_node("GameName").text = game.gameName
		newGameNode.texture_normal = load("res://" + game.image)
		$GameListMargin/ScrollContainer/HBoxContainer.add_child(newGameNode)
		newGameNode.pivot_offset = newGameNode.size / 2
		count += 1
	await get_tree().process_frame # wait before applying the scale otherwise it doesnt work
	get_node("GameListMargin/ScrollContainer/HBoxContainer/1").scale = Vector2(1.5, 1.5)
	get_node("GameListMargin/ScrollContainer/HBoxContainer/1").z_index = 1
	get_node("GameListMargin/ScrollContainer/HBoxContainer/1").grab_focus.call_deferred()


func _process(_delta: float) -> void:
	# Update time label
	var time = Time.get_time_dict_from_system()
	$Time.text = "%02d:%02d" % [time.hour, time.minute]


func move_game(direction):
	var old_game = get_node("ScrollContainer/HBoxContainer/" + str(current_game))
	old_game.scale = Vector2(1, 1)
	old_game.z_index = 0
	current_game += direction
	var new_game = get_node("ScrollContainer/HBoxContainer/" + str(current_game))
	new_game.scale = Vector2(1.5, 1.5)
	new_game.z_index = 1


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_right") and current_game < len(games):
		#move_game(1)
	#elif event.is_action_pressed("ui_left") and current_game > 1:
		#move_game(-1)
