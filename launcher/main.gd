extends Control

var gameNode = preload("res://gameNode.tscn")

var games = [
	{
		gameName = "Themes",
		image = "images/icons/paint.png",
	},
	{
		gameName = "Flynn's Shenanigans",
		image = "images/icons/Flynns shenanigans.png",
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


func open_app(gameNode):
	var appName = gameNode.get_node("GameName").text
	if appName == "Themes":
		$Themes.visible = true
		$Themes/VBoxContainer/ItemList.grab_focus()
		$Themes/VBoxContainer/ItemList.select(0)
	else:
		OS.execute(appName, [])


func load_theme() -> String:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	if err != OK:
		return "Zelda"
	
	return config.get_value("settings", "theme", "Zelda")


func _ready() -> void:
	var count = 1
	for game in games:
		var newGameNode = gameNode.instantiate()
		newGameNode.name = str(count)
		newGameNode.get_node("GameName").text = game.gameName
		newGameNode.texture_normal = load("res://" + game.image)
		$GameListMargin/ScrollContainer/HBoxContainer.add_child(newGameNode)
		newGameNode.pivot_offset = newGameNode.size / 2
		newGameNode.pressed.connect(func():
			open_app(newGameNode)
		)
		count += 1
	await get_tree().process_frame # wait before applying the scale otherwise it doesnt work
	get_node("GameListMargin/ScrollContainer/HBoxContainer/2").scale = Vector2(1.5, 1.5)
	get_node("GameListMargin/ScrollContainer/HBoxContainer/2").z_index = 1
	get_node("GameListMargin/ScrollContainer/HBoxContainer/2").grab_focus.call_deferred()
	$StartupSFX.play()
	var theme_name = load_theme()
	update_theme(theme_name)
	await $StartupSFX.finished
	await get_tree().create_timer(1.0).timeout
	$BgMusic.play()


func _process(_delta: float) -> void:
	# Update time label
	var time = Time.get_time_dict_from_system()
	$Time.text = "%02d:%02d" % [time.hour, time.minute]


func save_theme(theme_name: String):
	var config = ConfigFile.new()
	config.set_value("settings", "theme", theme_name)
	config.save("user://settings.cfg")


func update_theme(theme_name):
	if theme_name == "Zelda":
		$BackgroundTexture.texture = preload("res://images/backgrounds/Zelda Starfall.jpg")
		$BgMusic.stream = preload("res://audio/Zelda's Lullaby.ogg")
	elif theme_name == "Skylanders":
		$BackgroundTexture.texture = preload("res://images/backgrounds/Skylanders.png")
		$BgMusic.stream = preload("res://audio/Giants.ogg")
	elif theme_name == "Tearaway Unfolded":
		$BackgroundTexture.texture = preload("res://images/backgrounds/Tearaway Unfolded.png")
		$BgMusic.stream = preload("res://audio/The Orchards.ogg")


func _on_item_list_item_activated(index: int) -> void:
	var option = $Themes/VBoxContainer/ItemList.get_item_text(index)
	
	save_theme(option)
	update_theme(option)
	
	$BgMusic.play()
	$Themes.visible = false
	get_node("GameListMargin/ScrollContainer/HBoxContainer/1").grab_focus()


#func move_game(direction):
	#var old_game = get_node("ScrollContainer/HBoxContainer/" + str(current_game))
	#old_game.scale = Vector2(1, 1)
	#old_game.z_index = 0
	#current_game += direction
	#var new_game = get_node("ScrollContainer/HBoxContainer/" + str(current_game))
	#new_game.scale = Vector2(1.5, 1.5)
	#new_game.z_index = 1


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_right") and current_game < len(games):
		#move_game(1)
	#elif event.is_action_pressed("ui_left") and current_game > 1:
		#move_game(-1)
