define ['backbone', 'cs!model/Gallery'], (Backbone, model)->
	class Galleries extends Backbone.Collection
		model: model
		url:"/galleries/"
	new Galleries