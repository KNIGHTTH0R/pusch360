define [
  'backbone'
  'underscore'
], (Backbone, _)->
  class HotspotViewUser extends Backbone.View
    className: "hotspot"

    initialize:(args) ->
      @zoomStates = 5
      @$el.on "click", =>
        @trigger "clickModel", @model
      @rePosition()

    changeCurrentStep:(stepId)->
      @currentStep = stepId
      @rePosition()

    checkStep:->
      unless @model.attributes.positions[@currentStep]?
        @model.attributes.positions[@currentStep] =
          x: "1px"
          y: "1px"
          z: "1"

    rePosition:->
      @checkStep()
      hsPos = @model.attributes.positions[@currentStep]
      @$el.css
        top: hsPos.x
        left: hsPos.y
        transform: "scale("+hsPos.z+")"
