define [
  'backbone'
  'underscore'
  'text!templates/gallery.html'
], (Backbone, _, Template)->
  class GalleryView extends Backbone.View
    template: _.template Template
    render:->
    	@$el.html @template @model.toJSON()