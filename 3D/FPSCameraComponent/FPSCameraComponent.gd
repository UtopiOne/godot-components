extends Node3D

## CharacterBody3D affected by input
@export var target : CharacterBody3D
@export var neck : Node3D
@export var camera : Camera3D
@export var sensitivity : float
@export var x_rotation_clamp_minimum : int
@export var x_rotation_clamp_maximum : int

func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("ui_cancel"):
        get_tree().quit()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        target.rotate_y(deg_to_rad(-event.relative.x * sensitivity))

        neck.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
        neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(x_rotation_clamp_minimum), deg_to_rad(x_rotation_clamp_maximum))
