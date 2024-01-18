extends Control

@export_group("buttons")
@export var button_one: Button
@export var button_two: Button
@export var button_three: Button
@export var button_four: Button
@export var button_five: Button
@export var button_six: Button
@export var button_seven: Button
@export var button_eight: Button
@export var button_nine: Button
@export var button_zero: Button

@export_group("other buttons")
@export var calculator_display: Label
@export var clear_button: Button
@export var plus_sign_button: Button
@export var subtract_sign_button: Button
@export var equal_sign_button: Button

var current_number: int = 0
var stored_number: int = 0
var current_operation: String = ""
var star_new_operation: bool = false

func _ready() -> void:
	
	# buttons connections
	button_one.pressed.connect(on_number_button_pressed.bind(1))
	button_two.pressed.connect(on_number_button_pressed.bind(2))
	button_three.pressed.connect(on_number_button_pressed.bind(3))
	button_four.pressed.connect(on_number_button_pressed.bind(4))
	button_five.pressed.connect(on_number_button_pressed.bind(5))
	button_six.pressed.connect(on_number_button_pressed.bind(6))
	button_seven.pressed.connect(on_number_button_pressed.bind(7))
	button_eight.pressed.connect(on_number_button_pressed.bind(8))
	button_nine.pressed.connect(on_number_button_pressed.bind(9))
	button_zero.pressed.connect(on_number_button_pressed.bind(0))
	
	# clear button connection
	clear_button.pressed.connect(on_clear_pressed)
	
	# basic operation connections
	plus_sign_button.pressed.connect(on_sign_button_pressed.bind("+"))
	subtract_sign_button.pressed.connect(on_sign_button_pressed.bind("-"))
	
	# equal sign button connection
	equal_sign_button.pressed.connect(on_equal_sign_pressed)

func on_number_button_pressed(value: int) -> void:
	if not star_new_operation:
		current_number = (current_number * 10) + value
	else:
		current_number = value
		star_new_operation = false
	calculator_display.text = str(current_number)

func on_clear_pressed() -> void:
	current_number = 0
	calculator_display.text = str(current_number)

func on_sign_button_pressed(operation: String) -> void:
	
	# if true, no operation was assigned
	if current_operation == "":
		current_operation = operation		
		stored_number = current_number
		current_number = 0

func on_equal_sign_pressed() -> void:
	
	# add operation
	if current_operation == "+":
		current_number += stored_number

	# subtract operation
	elif current_operation == "-":
		current_number = stored_number - current_number
	
	# atualize values
	stored_number = 0
	calculator_display.text = str(current_number)
	current_operation = ""
	star_new_operation = true
