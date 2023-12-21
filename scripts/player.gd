class_name Player extends CharacterBody3D

@export_category("Player")
@export_range(1, 35, 1) var speed: float = 10 
@export_range(10, 100, 1) var acceleration: float = 35.0
@export_range(10, 1000, 1) var air_acceleration: float = 1000.0
@export_range(0, 20, 0.1) var floor_friction: float = 0.9
@export_range(1, 10, 0.1) var floor_speed_limit: float = 3.0
@export_range(0, 10, 0.1) var air_speed_limit: float = 0.6



@export_range(10, 400, 1) var jump_impulse: float = 4.0

@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1

var restart_transform : Transform3D
var restart_velocity : Vector3
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
	if Input.is_action_just_pressed("exit"): get_tree().quit()

func _physics_process(delta: float) -> void:
	velocity.y += -gravity * delta
	
	_jump(delta)
	var strafe_direction : Vector3 = _air_strafe_direction()

	var strafe_acceleration = acceleration if is_on_floor() else air_acceleration
	
	
	var accel = _source_acceleration(strafe_direction, strafe_acceleration, delta) 
	
	velocity += strafe_direction * accel
	move_and_slide()
	
	# after move and slide so the physics check is not done
	if Input.is_action_just_pressed("checkpoint"):
		print("Saving Checkpoint: %s / %s" % [self.transform, self.velocity])
		restart_transform = self.global_transform
		restart_velocity = self.velocity
	if Input.is_action_just_pressed("restart"):
		self.global_transform = restart_transform
		self.velocity = restart_velocity
	
	
func _source_acceleration(strafe_direction, strafe_acceleration, delta):
	var speed_limit = floor_speed_limit if is_on_floor() else air_speed_limit		
	# code based on Quakes project movement caused speed ups 
	# when parralel movement and rotation of player occurs # bhop accel and surf accel 
	var current_speed = strafe_direction.dot(velocity)
	var accel = strafe_acceleration * delta
	return max(0, min(accel, speed_limit - current_speed))
func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false

func _rotate_camera(sens_mod: float = 1.0) -> void:
	camera.rotation.y -= look_dir.x * camera_sens * sens_mod
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)


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
	elif is_on_floor():
		velocity *= floor_friction
	
