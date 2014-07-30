define [
  'backbone'
  'underscore'
  'text!templates/hotspot-detail.html'
], (Backbone, _, Template)->
  class HotspotDetailUserView extends Backbone.View

    el:'.overlay'

    initialize:->
      @on "click", ->
        @$el.hide()

    template: _.template Template

    render: ->
      @$el.html @template @model.toJSON()
