extends CharacterBody2D


@export var speed = 60
@export var jump_speed = -80
@export var gravity = 170
@export_range(0.0, 1.0) var friction = 0.4
@export_range(0.0, 1.0) var acceleration = 0.25
@export_range(0.0, 1.0) var deceleration = 1.0
@export var Knife : PackedScene
@export var cooldown = 2.25


var can_attack = true
var jumping = false
var attacking = false

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
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if velocity.length() > 0 and is_on_floor():
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("notsureyet")
	
	if velocity.x != 0:
		transform.x.x = sign(velocity.x)
	
func _ready():
	start()

func start():
	$KnifeCooldown.wait_time = cooldown


func attack():
	$AnimationPlayer.play("throwknife")
	#attacking = true
	var k = Knife.instantiate()
	owner.add_child(k)
	k.transform = $KnifeArm.global_transform
	#await $AnimationPlayer.animation_finished
	#attacking = false
