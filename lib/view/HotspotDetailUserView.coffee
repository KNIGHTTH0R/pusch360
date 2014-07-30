define [
  'backbone'
  'underscore'
  'text!templates/hotspot-detail.html'
], (Backbone, _, Template)->
  class HotspotDetailUserView extends Backbone.View
    className:'overlay'
    template: _.template Template
    render: ->
      @$el.html @template @model.toJSON()
      @
