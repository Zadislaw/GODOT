extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 64
const JUMP_HEIGHT = -550
var motion = Vector2(0, 0)
var isAtacking = false
var isDead = false
var isMovingLeft = true


func _ready():
	
	if isDead == false:
		$AnimatedSprite.play("Idle")

func _process(_delta):
	
	move_character()
	turn()
	
	

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		isMovingLeft = !isMovingLeft
		scale.x = -scale.x
		
func turn():
	if is_on_floor() and not $RayCast2D.is_colliding():
		isMovingLeft = !isMovingLeft
		scale.x = -scale.x

func move_character():
		
	motion.y += GRAVITY
	
	if isMovingLeft:
		motion.x = -SPEED
		$AnimatedSprite.play("Walk")
		
	else:
		motion.x = SPEED
		$AnimatedSprite.play("Walk")
		
	motion = move_and_slide(motion, UP)


func _on_Defector_area_entered(area):
	if area.is_in_group("Punch"):
		isDead = true
		$AnimatedSprite.play("Die")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Die":
		queue_free()
