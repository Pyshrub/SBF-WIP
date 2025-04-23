extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$P1_Health.value = Global.P1_Max
	$P1_Health.max_value = Global.P1_Max
	$P2_Health.max_value = Global.P2_Max
	$P2_Health.value = Global.P2_Max

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update_health():
	$P1_Health.value = Global.P1_HP
	$P2_Health.value = Global.P2_HP
