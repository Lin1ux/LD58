extends ItemAction
class_name SelectRandomProjectile




func execute(params : CastParams):
	var starred := params.item.get_starred_items()
	for star in starred:
		var charge :ItemEffect= star.get_node_or_null("get_charge")
		if charge != null:
			charge.execute(params)
