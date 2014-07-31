define [
  'backbone'
  'underscore'
  'text!templates/hotspot-edit.html'
  'cs!model/Hotspots'
  'cs!model/Hotspot'
], (Backbone, _, Template, Hotspots, Hotspot)->
  class HotspotDetailView extends Backbone.View

    initialize:->
      @render()

    template: _.template Template

    render: ->
      @$el.html @template
      @$el

    events:
      "click #newHotspot": "addHotspot"
      "click #removeHotspot": "removeHotspot"
      "click #saveHotspot": "saveHotspot"

    removeHotspot:->
      @model.destroy
        success:->
      @hideOverlay()

    changeModel: (model)->
      @model = model
      $('#hotspot-title').val model.attributes.title
      $('#hotspot-content').val model.attributes.content
      @showOverlay()

    saveHotspot:->
      @model.set
        title: $("#hotspot-title").val()
        content: $("#hotspot-content").val()
      @model.save()
      @hideOverlay()

    hideOverlay: ->
      $('.overlay').hide()

    showOverlay: ->
      $('.overlay').one "dblclick", -> $(@).hide()
      $('.overlay').show()


    addHotspot: ->
      that = @
      @model = new Hotspot
      Hotspots.create @model,
        success:->
          that.trigger "addHotspot", that.model
          that.render()
          that.showOverlay()
      return @model
