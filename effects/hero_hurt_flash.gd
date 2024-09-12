extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var red_border: TextureRect = $RedBorder

func _ready() -> void:
	Events.hero_hurt.connect(animation_player.play.bind("flash"))
