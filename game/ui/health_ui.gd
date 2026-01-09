extends Control

@onready var background_margin: MarginContainer = $Panel/BackgroundMargin
@onready var health_bar_margin: MarginContainer = $Panel/HealthBarMargin
@onready var health_label: Label = $Panel/HealthLabelMargin/HealthLabel


func resize_health_bar(value):
	background_margin.add_theme_constant_override("margin_right", value)


func remove_health(damage):
	health_label.text = str(int(health_label.text) - damage)
	var new_bar_size = int(190 + int(health_label.text) * (10 - 190) / 500)
	health_bar_margin.add_theme_constant_override("margin_right", new_bar_size)
	var tween = create_tween()
	tween.tween_method(resize_health_bar, background_margin.get_theme_constant("margin_right"), new_bar_size, 0.3)
	
	if int(health_label.text) <= 0:
		print("You died")

func reset_health():
	health_label.text = "500"
	health_bar_margin.add_theme_constant_override("margin_right", 10)
