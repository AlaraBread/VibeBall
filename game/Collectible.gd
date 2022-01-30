extends Area

export(int) var unique_id = 0

func _ready():
	var coin_ids = Serializer.get("coin_ids")
	if(unique_id in coin_ids):
		queue_free()

func _on_Collectible_body_entered(body):
	if(body.is_in_group("player")):
		Serializer.set("coins", Serializer.get("coins")+1)
		var coin_ids = Serializer.get("coin_ids")
		coin_ids.append(unique_id)
		Serializer.set("coin_ids", coin_ids)
		queue_free()

func _process(delta):
	$Coin.rotation.y += delta
