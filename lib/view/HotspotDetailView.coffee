define [
  'backbone'
  'underscore'
  'text!/lib/templates/hotspot-detail.html'
], (Backbone, _, Template)->
  class HotspotDetailView extends Backbone.View
    initialize:(args) ->
      @$el.hide()
    template: _.template Template

    render: ->
      @$el.html @template @model.toJSON()

    events:
      "click #newHotspot": "addHotspot"
      "click #editHotspot": "editHotspot"

    saveHotspot:->
      @model.set
        title: $("#hotspot-title").val()
        content: $("#hotspot-content").val()
      @model.save()
      @$el.hide()

    editHotspot: (hotspot)->
      return unless hotspot?
      @model = hotspot
      @render()
      @$el.show()

    addHotspot: ->
      that = @
      @model = new Hotspot
      @Hotspots.create @model,
        success:->
          that.$el.show()

