extends Level

@onready var camera_target: RemoteTransform2D = $CameraTarget
@onready var boss_barrier: StaticBody2D = $BossBarrier
@onready var trigger: Area2D = $Trigger
@onready var vampire_boss: VampireBoss = $VampireBoss

@onready var stasher: = Stasher.new().set_target(self)

func _ready() -> void:
	if stasher.retrieve_property("trigger_freed"): trigger.queue_free()
	super()
	Events.request_camera_target.emit.call_deferred(camera_target)
	trigger.body_entered.connect(func(body: Node2D):
		boss_barrier.show()
		boss_barrier.set_collision_layer_value(1, true)
		trigger.queue_free()
		stasher.stash_property("trigger_freed", true)
	)
	vampire_boss.stats.no_health.connect(func():
		boss_barrier.hide()
		boss_barrier.set_collision_layer_value(1, false)
	)
	
	
