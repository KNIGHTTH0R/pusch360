define [
  'backbone'
  'underscore'
  'text!templates/hotspot-detail.html'
  'cs!model/Hotspots'
  'cs!model/Hotspot'
], (Backbone, _, Template, Hotspots, Hotspot)->
  class HotspotDetailView extends Backbone.View

    template: _.template Template

    render: ->
      @$el.html @template @model.toJSON()
      @

    events:
      "click #newHotspot": "addHotspot"
      "click #removeHotspot": "removeHotspot"
      "click #saveHotspot": "saveHotspot"

    deleteHotspot:->
      @model.destroy
        success:->
          console.log "deleted hs"

    saveHotspot:->
      @model.set
        title: $("#hotspot-title").val()
        content: $("#hotspot-content").val()
      @model.save()
      @$el.find(".overlay").hide()

    editHotspot: (hotspot)->
      console.log "edit hs!!"
      return unless hotspot?
      console.log hotspot
      @model = hotspot
      @render()
      @$el.parent().parent().find(".overlay").show()

    addHotspot: ->
      that = @
      @model = new Hotspot
      Hotspots.create @model,
        success:->
          that.$el.find(".overlay").show()

