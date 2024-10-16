class_name EnemyResource
extends Resource

enum MovementType { 
	BASIC, 
	UP_AND_DOWN,
	FAST, 
}

@export var health: int
@export var speed: int
@export var movement_type: MovementType
