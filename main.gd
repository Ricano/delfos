extends Node2D

@onready var input := $input
@onready var answer := $answer
@onready var waves := $waves
@onready var background := $background
@onready var instructions := $instructions
@onready var title := $title
@onready var reload_button := $sprite/reload_button
@onready var sfx := $sfx
@onready var papyrus := $papyrus
@onready var column_left := $column_left
@onready var column_right := $column_right


var fake := "Oh bela e nova Gina, tu és quem mais me ensina."
var fake_len : int
var fake_counter := 0
var real := ""
var fill_mode := true

func _ready():
	fake_len = len(fake)


func _process(delta):
	$light.global_position = get_global_mouse_position()
	
	
func _input(event):
	if event.is_action_pressed("secret"):
		answer.text = real
		fill_mode = false

func _on_input_text_changed(new_text):
	if fake_counter < fake_len:
		fake_counter +=1
		input.text = fake.substr(0, fake_counter)
		input.caret_column = fake_counter
	if fill_mode:
		real+=new_text[-1]
	


func _on_input_text_submitted(new_text):
	instructions.visible = false
	input.visible = false
	waves.visible = true
	sfx.play()
	await get_tree().create_timer(3).timeout
	show_answer()
	
func show_answer():
	waves.visible = false
	title.visible = false
	papyrus.visible = false
	column_left.visible = false
	column_right.visible = false
	background.modulate = Color.BLACK
	if answer.text == "":
		answer.text = "Eu sou a GINA"

	get_tree().create_tween().tween_property(answer, "modulate", Color(answer.modulate.r, answer.modulate.g,answer.modulate.b, 1), 3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)


func _on_reload_button_pressed():
	get_tree().reload_current_scene()	
