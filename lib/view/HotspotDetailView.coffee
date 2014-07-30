define [
  'backbone'
  'underscore'
  'text!templates/hotspot-edit.html'
  'cs!model/Hotspots'
  'cs!model/Hotspot'
], (Backbone, _, Template, Hotspots, Hotspot)->
  class HotspotDetailView extends Backbone.View

    initialize:->
      if @model then @render()

    template: _.template Template

    render: ->
      @template @model.toJSON()


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
      @hideOverlay()

    hideOverlay: ->
      @$el.parent().hide()

    showOverlay: ->
      @$el.parent().show()

    addHotspot: ->
      that = @
      @model = new Hotspot
      Hotspots.create @model,
        success:->
          that.trigger "addHotspot", that.model
          that.render()
          that.showOverlay()
      return @model
