extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2()
var double_jump = false
var isAtacking = false
var isMovingLeft = true

func _physics_process(_delta):
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right") && isAtacking == false:
		motion.x = SPEED
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
		isMovingLeft = false
	elif Input.is_action_pressed("ui_left") && isAtacking == false:
		motion.x = -SPEED
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
		isMovingLeft = true
	else:
		motion.x = 0
		if isAtacking == false:
			$AnimatedSprite.play("Idle")
		
	if is_on_floor():
		double_jump = true;
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			
	else:
		$AnimatedSprite.play("Jump")
	
	if Input.is_action_just_pressed("ui_up"):
		if double_jump and not is_on_floor():	
			motion.y = JUMP_HEIGHT
			double_jump = false
			$AnimatedSprite.play("Jump")
			
	if Input.is_action_just_pressed("Attack") and is_on_floor():
		$AnimatedSprite.play("Atack")
		isAtacking = true
		$AttackArea/AttackCollision.disabled = false
		
	
	motion = move_and_slide(motion, UP)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Atack":
		$AttackArea/AttackCollision.disabled = true
		isAtacking = false
