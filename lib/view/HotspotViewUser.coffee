define [
  'backbone'
  'underscore'
  'text!templates/hotspot.html'
], (Backbone, _, Template)->
  class HotspotView extends Backbone.View
    className: "hotspot"

    initialize:(args) ->
      @zoomStates = 5
      @rePosition()
      @$el.bind "click", ->
        $(@).toggleClass("active")
        console.log "click"

    template: _.template Template

    changeCurrentStep:(stepId)->
      @currentStep = stepId
      @rePosition()

    rePosition:->
      hsPos = @model.attributes.positions[@currentStep]
      @$el.find(".hotspot").css
        top: hsPos.x
        left: hsPos.y
        transform: "scale("+hsPos.z+")"

    render: ->
      @$el.html @template @model.toJSON()
      @
