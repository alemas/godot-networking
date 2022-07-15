extends Spatial

export var spawn_points: PoolVector3Array
var entities: Array
var players: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func spawn_player(player: KinematicBody):
	var spawn_point = spawn_points[0]
	player.global_transform.origin = spawn_point
