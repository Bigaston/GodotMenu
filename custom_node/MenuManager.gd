@icon("res://addons/me.bigaston.menu/icons/menu_manager.svg")

extends Control
class_name MenuManager

signal page_change(from: MenuPage, to: MenuPage)
signal go_backward(from: MenuPage)
signal final_go_backward()

@export var default_page: MenuPage
@export var auto_open_page = true

var _current_page: MenuPage
var _available_pages: Array[MenuPage]
var _menu_stack: Array[MenuPage]
var _is_current_manager = false

@onready var log = Logger.new("MenuPage:" + name, Color.AQUAMARINE)

func _ready():
	_available_pages.clear()
	
	for child in get_children():
		if child is MenuPage:
			_available_pages.push_back(child)
			child.visible = false
			child.flow_event.connect(_on_flow_event.bind(child))
			
	if _available_pages.size() == 0:
		log.error("No MenuPages under the MenuManager")
		return
	
	if default_page != null:
		if auto_open_page:
			await change_page(default_page)
	elif _available_pages.size() > 0:
		if auto_open_page:
			await change_page(_available_pages[0])
	else:
		log.error("Can't setup a _current_page")
		
func _process(_delta):
	if Input.is_action_just_pressed("menu_back") && _is_current_manager:
		back()

func change_page(page: MenuPage, stack: bool = true):
	page_change.emit(_current_page, page)
	_is_current_manager = true
	
	if _current_page != null:
		await _current_page.play_exit_animation()
		_current_page.on_exit()
		
	_current_page = page
	
	if stack:
		_menu_stack.push_front(page)
	
	_current_page.on_enter()
	await _current_page.play_enter_animation()
	
	if _current_page.sub_manager != null:
		_is_current_manager = false

func add_page_to_stack(page: MenuPage):
	_menu_stack.push_front(page)

func back():
	if _menu_stack.size() < 2:
		_is_current_manager = false
		final_go_backward.emit()
		return
		
	go_backward.emit(_menu_stack[0])
	
	_menu_stack.pop_front()
	
	change_page(_menu_stack[0], false)

func _on_flow_event(page_name: StringName, page: MenuPage):
	for child in get_children():
		if child is MenuPage:
			if child.name == page_name:
				change_page(child)
				return
				
	log.warn("Can't find page for " + page_name)
	
func close():
	get_parent().queue_free()
	
func open_default_page(clear_stack = true):
	if clear_stack:
		_menu_stack.clear()
		
	await change_page(default_page)

func hide_page():
	if _current_page != null:
		await _current_page.play_exit_animation()
		_current_page.on_exit()
