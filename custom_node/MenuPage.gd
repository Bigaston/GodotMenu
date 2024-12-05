@icon("res://addons/me.bigaston.menu/icons/menu_page.svg")

extends Control
class_name MenuPage

signal flow_event(event_name: StringName)

@export var timeline: AnimationPlayer
@export var default_control: Control

@export var sub_manager: MenuManager

@export_category("Menu Flow")
@export var button_flow: Array[MenuButtonFlow]

func _ready():
	assert(get_parent() is MenuManager, "The parrent is not a MenuManager")
	
	# Button Flow Managements
	for button_flow in button_flow:
		var btn = get_node(button_flow.button) as Button
		btn.pressed.connect(func():
			flow_event.emit(button_flow.event_name)
			)
	
	print(name + " " + str(sub_manager))
	
	if sub_manager != null:
		print("Has SubManager")
		sub_manager.final_go_backward.connect(func():
			print("Has Final Backward in children")
			get_parent().back())

func play_enter_animation():
	visible = true
	
	if timeline != null && timeline.has_animation("enter"):
		if default_control != null:
			default_control.grab_focus()
		
		timeline.play("enter")
		await timeline.animation_finished
		
	if sub_manager:
		sub_manager.open_default_page()

func play_exit_animation():
	if sub_manager:
		await sub_manager.hide_page()
	
	if timeline != null && timeline.has_animation("exit"):
		timeline.play("exit")
		await timeline.animation_finished
		visible = false

func on_enter():
	pass
	
func on_exit():
	pass
