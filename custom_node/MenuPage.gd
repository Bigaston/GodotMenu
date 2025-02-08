@icon("res://addons/me.bigaston.menu/icons/menu_page.svg")

extends Control
class_name MenuPage

signal flow_event(page_name: StringName)

@export var timeline: AnimationPlayer

@export_subgroup("Controls")
@export var default_control: Control
@export var button_flow: Dictionary[Button,StringName] = {}

@export_subgroup("Advanced")
@export var sub_manager: MenuManager

@onready var log = Logger.new("MenuPage:" + name, Color.AQUAMARINE)

func _ready():
	log.check(get_parent() is MenuManager, "The parrent is not a MenuManager")
	
	# Button Flow Managements
	for btn in button_flow.keys():
		btn.pressed.connect(func():
			flow_event.emit(button_flow[btn])
			)
	
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
