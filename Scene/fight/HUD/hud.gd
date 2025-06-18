extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$P1_Health.value = Global.P1_Max
	$P1_Health.max_value = Global.P1_Max
	$P2_Health.max_value = Global.P2_Max
	$P2_Health.value = Global.P2_Max
	$P1_SP.value = Global.P1_SP
	$P2_SP.value = Global.P2_SP



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $P1_SP.value >= 20:
		$P1_SP.self_modulate = Color(0,1,0)
	if $P1_SP.value < 20:
		$P1_SP.self_modulate = Color(0,0,1)
	if $P2_SP.value >= 20:
		$P2_SP.self_modulate = Color(0,1,0)
	if $P2_SP.value < 20:
		$P2_SP.self_modulate = Color(0,0,1)
func update_health():
	$P1_Health.value = Global.P1_HP
	$P2_Health.value = Global.P2_HP
func update_SP():
	$P1_SP.value = Global.P1_SP
	$P2_SP.value = Global.P2_SP
