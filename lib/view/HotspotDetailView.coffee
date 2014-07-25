define [
  'backbone'
  'underscore'
  'text!templates/hotspot-detail.html'
  'cs!model/Hotspots'
  'cs!model/Hotspot'
], (Backbone, _, Template, Hotspots, Hotspot)->
  class HotspotDetailView extends Backbone.View

    el:'.editHotspot'

    initialize:->
      @render()

    template: _.template Template

    render: ->
      @$el.html @template @model.toJSON()

    events:
      "click #newHotspot": "addHotspot"
      "click #removeHotspot": "removeHotspot"
      "click #saveHotspot": "saveHotspot"

    removeHotspot:->
      @model.destroy
        success:->
      @hideOverlay()

    saveHotspot:->
      @model.set
        title: $("#hotspot-title").val()
        content: $("#hotspot-content").val()
      @model.save()
      @$el.find(".overlay").hide()

    hideOverlay: ->
      @$el.parent().parent().find(".overlay").hide()

    showOverlay: ->
      @$el.parent().parent().find(".overlay").show()

    addHotspot: ->
      that = @
      @model = new Hotspot
      Hotspots.create @model,
        success:->
          that.trigger "addHotspot", that.model
          that.render()
          that.showOverlay()
