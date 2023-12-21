class_name Player extends CharacterBody3D

@export_category("Player")
@export_range(1, 35, 1) var speed: float = 10 
@export_range(10, 100, 1) var acceleration: float = 35.0
@export_range(10, 100, 1) var air_acceleration: float = 1000.0
@export_range(10, 20, 0.1) var floor_friction: float = 0.9
@export_range(1, 10, 0.1) var floor_speed_limit: float = 3.0
@export_range(1, 10, 0.1) var air_speed_limit: float = 0.6



@export_range(10, 400, 1) var jump_impulse: float = 4.0

@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1

var restart_transform : Transform3D
var restart_velocity : Vector3
var direction = Vector3()
var friction = 4
var wish_jump
var walking = false

var jumping: bool = false
var mouse_captured: bool = false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var move_dir: Vector2 
var look_dir: Vector2

var walk_vel: Vector3
var grav_vel: Vector3
var jump_vel: Vector3

@onready var camera := $Camera as Area3D

func _ready() -> void:
	capture_mouse()
	restart_transform = self.global_transform
	restart_velocity = self.velocity

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if mouse_captured: _rotate_camera()
	if Input.is_action_just_pressed("jump"): jumping = true
	if Input.is_action_just_pressed("exit"): get_tree().quit()

func _physics_process(delta: float) -> void:
	if mouse_captured: _handle_joypad_camera_rotation(delta)
	velocity.y += -gravity * delta
	
	_jump(delta)
	var strafe_direction : Vector3 = _air_strafe_direction()

	var strafe_acceleration = acceleration if is_on_floor() else air_acceleration
	var speed_limit = floor_speed_limit if is_on_floor() else air_speed_limit
	
	# Project current velocity onto the strafe direction, and compute a capped
	# acceleration such that *projected* speed will remain within the limit.
	var current_speed = strafe_direction.dot(velocity)
	var accel = strafe_acceleration * delta
	accel = max(0, min(accel, speed_limit - current_speed))
	
	# Apply strafe acceleration to velocity and then integrate motion
	velocity += strafe_direction * accel
	move_and_slide()
	
	if Input.is_action_just_pressed("checkpoint"):
		print("Saving Checkpoint: %s / %s" % [self.transform, self.velocity])
		restart_transform = self.global_transform
		restart_velocity = self.velocity	
	
	if Input.is_action_just_pressed("restart"):
		self.global_transform = restart_transform
		self.velocity = restart_velocity
	
	

func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_camera(sens_mod: float = 1.0) -> void:
	#camera.rotate_camera(look_dir.x * camera_sens * sens_mod, clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5))
	camera.rotation.y -= look_dir.x * camera_sens * sens_mod
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)

func _handle_joypad_camera_rotation(delta: float, sens_mod: float = 1.0) -> void:
	var joypad_dir: Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if joypad_dir.length() > 0:
		look_dir += joypad_dir * delta
		_rotate_camera(sens_mod)
		look_dir = Vector2.ZERO

func _walk(delta: float) -> Vector3:
	move_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var _forward: Vector3 = camera.global_transform.basis * Vector3(move_dir.x, 0, move_dir.y)
	var walk_dir: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	walk_vel = walk_vel.move_toward(walk_dir * speed * move_dir.length(), acceleration * delta)
	return walk_vel


func _air_strafe_direction() -> Vector3:
	var cam_basis = camera.get_global_transform().basis
	var strafe_dir = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		strafe_dir -= cam_basis.z
	if Input.is_action_pressed("move_backward"):
		strafe_dir += cam_basis.z
	if Input.is_action_pressed("move_left"):
		strafe_dir -= cam_basis.x
	if Input.is_action_pressed("move_right"):
		strafe_dir += cam_basis.x
	strafe_dir.y = 0
	return strafe_dir.normalized()


func _jump(delta: float):
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_impulse
		jumping = false
	elif is_on_floor():
		velocity *= floor_friction
	
