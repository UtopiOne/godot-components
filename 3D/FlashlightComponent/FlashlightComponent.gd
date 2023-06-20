extends Node3D

@export var light : Light3D

func _input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("flashlight_toggle"):
        print("action")
        light.visible = !light.visible
