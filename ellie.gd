extends CharacterBody2D


@export var speed = 60
@export var jump_speed = 20
@export var gravity = 130
@export_range(0.0, 1.0) var friction = 0.4
@export_range(0.0, 1.0) var acceleration = 0.25
@export_range(0.0, 1.0) var deceleration = 1.0

var jumping = false
#var attacking = false

func _physics_process(delta):
	velocity.y += gravity * delta
	
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	if velocity.length() > 0:
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("notsureyet")
	
	if velocity.x != 0:
		transform.x.x = sign(velocity.x)
	
#jump
func _input(event):
	if event.is_action_pressed("jump"):
		jump()
	if event.is_action_pressed("attack"):
		attack()

func jump():
	$AnimationPlayer.play("jump")
	jumping = true
	await $AnimationPlayer.animation_finished
	jumping = false
	
func attack():
	$AnimationPlayer.play("throwknife")
	#attacking = true
	#await $AnimationPlayer.animation_finished
	#attacking = false
