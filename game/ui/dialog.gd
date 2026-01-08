extends Control

var dialog_visible = false


func is_dialog_visible():
	if dialog_visible:
		return true
	else:
		return false


func show_dialog(text):
	dialog_visible = true
	$Panel/MarginContainer/HBoxContainer/RichTextLabel.text = "[color=yellow]Flynn:[/color] " + text
	var showPanelTween = get_tree().create_tween()
	showPanelTween.tween_property($Panel, "position", Vector2(276, 548), 0.2).set_trans(Tween.TRANS_LINEAR)


func hide_dialog():
	var hidePanelTween = get_tree().create_tween()
	hidePanelTween.tween_property($Panel, "position", Vector2(276, 648), 0.2).set_trans(Tween.TRANS_LINEAR)
	await hidePanelTween.finished
	dialog_visible = false
