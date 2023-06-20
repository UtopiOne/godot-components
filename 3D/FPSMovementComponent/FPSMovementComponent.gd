extends Node3D

@export var target : CharacterBody3D

@export var walk_speed : float
@export var sprint_speed : float
@export var jump_velocity = 4.5
@export var sprint_speed_up = 1.5

var SPEED : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
    SPEED = walk_speed


func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not target.is_on_floor():
        target.velocity.y -= gravity * delta


    if Input.is_action_pressed("sprint"):
        SPEED = sprint_speed
    if Input.is_action_just_released("sprint"):
        SPEED = walk_speed

    # Handle Jump.
    if Input.is_action_just_pressed("jump") and target.is_on_floor():
        target.velocity.y = jump_velocity
        GlobalAudioServer.player_jump.play()

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
    var direction := (target.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    if direction:
        target.velocity.x = direction.x * SPEED
        target.velocity.z = direction.z * SPEED
    else:
        target.velocity.x = move_toward(target.velocity.x, 0, SPEED * 0.5)
        target.velocity.z = move_toward(target.velocity.z, 0, SPEED * 0.5)

    target.move_and_slide()
