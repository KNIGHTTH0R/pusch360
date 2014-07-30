define [
  'backbone'
  'underscore'
  'text!templates/hotspot-detail.html'
], (Backbone, _, Template)->
  class HotspotDetailUserView extends Backbone.View

    className:'overlay'

    initialize:->
      @$el.on "click", =>
        @$el.parent().hide()

    template: _.template Template

    render: ->
      @$el.html @template @model.toJSON()
      @
