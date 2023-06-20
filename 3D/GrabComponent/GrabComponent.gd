extends Node3D

@export var target : CharacterBody3D
@export var raycast : RayCast3D
@export var destination : Marker3D
@export var pull_force : float
@export var throw_force : float

@onready var timer = $Timer

var picked = false
var picked_object : Object

func _input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("interact"):
        picked_object = raycast.get_collider()
        picked = !picked


func _physics_process(delta: float) -> void:
    pick_object(picked_object)
    print(picked_object)

    if is_instance_valid(raycast.get_collider()):
        timer.start()


func pick_object(picked_object: RigidBody3D):
    if picked_object and picked:

        var a = picked_object.global_transform.origin
        var b = destination.global_transform.origin
        picked_object.set_linear_velocity((b-a) * pull_force)

        if Input.is_action_just_pressed("throw"):
            picked = false
            picked_object.apply_impulse(-raycast.global_transform.basis.z * throw_force)


func _on_timer_timeout() -> void:
    picked = !picked
    picked_object = null
