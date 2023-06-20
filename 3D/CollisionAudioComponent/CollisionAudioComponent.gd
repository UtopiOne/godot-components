extends Node3D
class_name CollisionAudioComponent

@export var sounds : Array[AudioStream]

@onready var player = $Player

var playable = false

func _ready() -> void:
    player.stream = sounds.pick_random()

func play_collision_sound(body: Node):
    var sound = sounds.pick_random()

    if !player.playing and playable:
        player.stream = sound
        player.play()


func _on_level_spawn_delay_timeout() -> void:
    playable = true
