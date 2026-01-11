extends Node3D

const tent: PackedScene = preload("res://maps/tent/tent.tscn")
const castle: PackedScene = preload("res://maps/castle/castle.tscn")

const meteor_scene: PackedScene = preload("res://meteor/meteor.tscn")
const tornado_scene: PackedScene = preload("res://tornado/tornado.tscn")
@onready var video: VideoStreamPlayer = $CanvasLayer/VideoStreamPlayer

@onready var round_ui: Control = $CanvasLayer/RoundUI
@onready var warning_label: Label = $CanvasLayer/RoundUI/Disaster/MarginContainer/VBoxContainer/CenterContainer/WarningLabel
@onready var description_label: Label = $CanvasLayer/RoundUI/Disaster/MarginContainer/VBoxContainer/CenterContainer2/DescriptionLabel
@onready var map_name_label: Label = $CanvasLayer/RoundUI/Map/MarginContainer/VBoxContainer/CenterContainer2/MapNameLabel

var roundFinished = false
signal roundFinishedSignal

var currentMap = ""

var disasterFunctions = [
	meteor_shower,
	tornado
]

var maps = [
	tent,
	castle
]

func _ready() -> void:
	$CanvasLayer/HealthUI.died.connect(_on_round_timer_timeout)
	start_round()


func start_round():
	roundFinished = false
	$RoundTimer.start()
	await choose_map()
	disasterFunctions.pick_random().call()


func choose_map():
	var map = maps.pick_random().instantiate()
	map_name_label.text = map.name
	currentMap = map.name
	map.name = "Map"
	map.position = Vector3(0, 1, 0)
	add_child(map)
	
	var showPanelTween = get_tree().create_tween()
	showPanelTween.tween_property(round_ui.get_node("Map"), "position", Vector2(376, 0), 0.5).set_trans(Tween.TRANS_ELASTIC)
	await get_tree().create_timer(5.0).timeout
	var hidePanelTween = get_tree().create_tween()
	hidePanelTween.tween_property(round_ui.get_node("Map"), "position", Vector2(376, -100), 0.5).set_trans(Tween.TRANS_ELASTIC)
	await hidePanelTween.finished


func show_round_ui(description):
	description_label.text = description
	
	var flashWarningTween = get_tree().create_tween().set_loops()
	flashWarningTween.tween_property(warning_label, "theme_override_constants/outline_size", 0, 0.2)
	flashWarningTween.tween_property(warning_label, "theme_override_constants/outline_size", 10, 0.2)
	
	var showPanelTween = get_tree().create_tween()
	showPanelTween.tween_property(round_ui.get_node("Disaster"), "position", Vector2(376, 0), 0.5).set_trans(Tween.TRANS_ELASTIC)
	await get_tree().create_timer(3.0).timeout
	var hidePanelTween = get_tree().create_tween()
	hidePanelTween.tween_property(round_ui.get_node("Disaster"), "position", Vector2(376, -100), 0.5).set_trans(Tween.TRANS_ELASTIC)
	flashWarningTween.kill()
	$InvisWall/CollisionShape3D.disabled = true


func meteor_shower():
	show_round_ui("Avoid the meteor shower")
	while not roundFinished:
		var new_meteor = meteor_scene.instantiate()
		
		# get random position in circle
		var angle = randf_range(0, TAU) 
		var distance = sqrt(randf_range(0, 1)) * 10
		var random_offset = Vector2(distance, 0).rotated(angle)
		var new_pos = Vector3(random_offset.x, 10, random_offset.y)
		
		new_meteor.position = Vector3(random_offset.x, 10, random_offset.y)
		
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(new_pos, new_pos + Vector3.DOWN * 2000)
		query.exclude = [$Player.get_rid()]
		query.collide_with_areas = false # maybe slightly improve performance
		var result = space_state.intersect_ray(query)
		if result:
			new_meteor.get_node("Target").position = result.position + Vector3(0, 0.1, 0)
		else:
			new_meteor.get_node("Target").position = Vector3(random_offset.x, 1.01, random_offset.y)
		
		new_meteor.body_entered.connect(new_meteor._on_body_entered)
		
		add_child(new_meteor)
		await get_tree().create_timer(0.1).timeout


func tornado():
	video.show()
	video.play()

func _on_video_finished() -> void:
	video.hide()
	show_round_ui("Tornadonut! Stay clear of its path")
	var new_tornado = tornado_scene.instantiate()
	new_tornado.position = Vector3(15, 7, -15)
	add_child(new_tornado)
	
	if currentMap == "Castle" and randi_range(1, 2) == 1:
		get_node("/root/Main/Voiceline").stream = preload("res://voicelines/wowzers now thats a twister.ogg")
		get_node("/root/Main/CanvasLayer/Dialog_UI").show_dialog("Wowzers, now that's a twister and it's ripping that castle to pieces. It's almost as impressive as me - almost.")
		get_node("/root/Main/Voiceline").play()
		await get_node("/root/Main/Voiceline").finished
		get_node("/root/Main/CanvasLayer/Dialog_UI").hide_dialog()
	
	await roundFinishedSignal
	new_tornado.queue_free()


func _on_round_timer_timeout() -> void:
	if roundFinished: # for some reason this function keeps getting called multiple times
		return
	roundFinished = true
	roundFinishedSignal.emit()
	$InvisWall/CollisionShape3D.set_deferred("disabled", false)
	$CanvasLayer/HealthUI.reset_health()
	var showPanelTween = get_tree().create_tween()
	showPanelTween.tween_property(round_ui.get_node("Intermission"), "position", Vector2(376, 0), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_node("Map").queue_free()
	currentMap = ""
	$IntermissionTimer.start()
	$IntermissionMusic.play()
	$Player.position = Vector3(0, 1, 6)
	
	if randi_range(1, 5) == 1 and not $CanvasLayer/Dialog_UI.is_dialog_visible():
		var randVoiceline = randi_range(1, 2)
		if randVoiceline == 1:
			$CanvasLayer/Dialog_UI.show_dialog("That was beautiful...")
			$Voiceline.stream = preload("res://voicelines/that was beautiful.ogg")
		else:
			$CanvasLayer/Dialog_UI.show_dialog("Woo! Well, that was a close one - yet somehow I was able to lead us through.")
			$Voiceline.stream = preload("res://voicelines/that was a close one.ogg")
		$Voiceline.play()
		await $Voiceline.finished
		$CanvasLayer/Dialog_UI.hide_dialog()
	
	await $IntermissionTimer.timeout
	if randi_range(1, 5) == 1:
		get_node("/root/Main/Voiceline").stream = preload("res://voicelines/piece of cake.ogg")
		get_node("/root/Main/CanvasLayer/Dialog_UI").show_dialog("This is gonna be a piece of cake especially for heroes like us - heroes who like cake.")
		get_node("/root/Main/Voiceline").play()
		await get_node("/root/Main/Voiceline").finished
		get_node("/root/Main/CanvasLayer/Dialog_UI").hide_dialog()
	var hidePanelTween = get_tree().create_tween()
	hidePanelTween.tween_property(round_ui.get_node("Intermission"), "position", Vector2(376, -100), 0.5).set_trans(Tween.TRANS_ELASTIC)
	await hidePanelTween.finished
	round_ui.get_node("Intermission/MarginContainer/VBoxContainer/CenterContainer/CompleteLabel").text = "Round Complete"
	$IntermissionMusic.stop()
	start_round()
