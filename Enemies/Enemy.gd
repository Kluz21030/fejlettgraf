class_name Enemy extends CharacterBody3D

var player: Player

@export var movement_speed: int = 5

@onready var skin: Node3D = $Skeleton_Minion
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
