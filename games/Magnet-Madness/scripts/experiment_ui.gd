extends Control
## ExperimentUI - Display during experiment phase

@onready var timer_label: Label = $TimerLabel
@onready var emergency_stop_button: Button = $EmergencyStopButton
@onready var bleep_status: Label = $BleepStatus
@onready var scientist_portrait: Sprite2D = $ScientistPortrait

func _ready():
	emergency_stop_button.pressed.connect(_on_emergency_stop)
	visible = false

func update_timer(time_remaining: float):
	var seconds = int(ceil(time_remaining))
	timer_label.text = "Time: %d" % seconds

func update_bleed_state(health: float, glitch: String):
	bleep_status.text = "Health: %d%%" % health
	if glitch != "":
		bleep_status.text += "\nGlitch: %s" % glitch.capitalize()
	else:
		bleep_status.text += "\nStatus: Normal"

func _on_emergency_stop():
	GameManager.emergency_stop()

func _process(_delta):
	if visible and emergency_stop_button:
		emergency_stop_button.disabled = not GameManager.emergency_stop_available
		if not GameManager.emergency_stop_available:
			emergency_stop_button.text = "USED"
		else:
			emergency_stop_button.text = "EMERGENCY STOP"
