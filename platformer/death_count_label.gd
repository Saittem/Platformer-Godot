extends Label

func _process(delta):
	text = "Death Count: " + str(Global.death_count)
