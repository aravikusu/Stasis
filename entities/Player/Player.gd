extends CharacterBody3D
class_name Player

@onready var rem: Rem = $rem
@onready var spring_arm_pivot := $SpringArmPivot
@onready var spring_arm := $SpringArmPivot/SpringArm3D
@onready var camera := %Camera3D

const SPEED = 3.5
const JUMP_VELOCITY = 4.5
const LERP_VAL = .15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Global.GAME_STATE != Enums.GAME_STATE.TITLE_SCREEN:
		if event is InputEventMouseMotion:
			spring_arm_pivot.rotate_y(-event.relative.x * .005)
			spring_arm.rotate_x(-event.relative.y * .005)
			
			spring_arm.rotation.x = clamp(spring_arm.rotation.x, -PI/4, PI/4)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Global.GAME_STATE != Enums.GAME_STATE.TITLE_SCREEN:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("left", "right", "forward", "back")
		var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		direction = direction.rotated(Vector3.UP, spring_arm_pivot.rotation.y)
		if direction:
			velocity.x = lerp(velocity.x, direction.x * SPEED, LERP_VAL)
			velocity.z = lerp(velocity.z, direction.z * SPEED, LERP_VAL)
			rem.rotate_armature_y(atan2(-velocity.x, -velocity.z), LERP_VAL)
		else:
			velocity.x = lerp(velocity.x, 0.0, LERP_VAL)
			velocity.z = lerp(velocity.z, 0.0, LERP_VAL)

	move_and_slide()
	
	rem.set_anim_tree_walk(velocity.length() / SPEED)

func play_transition_animation(transition: String, value: String) -> void:
	if transition == "loop":
		rem.set_anim_tree_loop_transition(value)

func play_oneshot_animation(oneshot: String) -> void:
	if oneshot == "title_lean_end":
		rem.set_anim_tree_title_lean_end()

func set_active() -> void:
	camera.current = true

func _on_rem_interact(collider: Object) -> void:
	if collider is InteractArea:
		collider.activate()
