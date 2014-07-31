define [
  'backbone'
  'underscore'
], (Backbone, _)->
  class HotspotView extends Backbone.View
    className: "hotspot"
    initialize:(args) ->
      @zoomStates = 5
      @rePosition()
      @model.on "change", @render, @
      @model.on "destroy", @destroy, @
      @$el.bind "dragstop", @setCurrentPosition.bind(@)
      @$el.bind "mousewheel", @scroll.bind(@)
      @$el.bind "dblclick", =>
        @trigger "editHotspot", @model

    destroy:->
      @$el.unbind()
      @unbind()
      @remove()
      console.log "removed"

    scroll: (e)->
      @checkStep()
      size = parseInt @model.attributes.positions[@currentStep].z
      size = (size+1) % @zoomStates
      @model.attributes.positions[@currentStep].z = size || 1
      @model.save()
      @rePosition()
      return false

    changeCurrentStep:(stepId)->
      @currentStep = stepId
      @rePosition()

    rePosition:->
      @checkStep()
      hsPos = @model.attributes.positions[@currentStep]
      @$el.css
        top: hsPos.x
        left: hsPos.y
        transform: "scale("+hsPos.z+")"


    checkStep:->
      unless @model.attributes.positions[@currentStep]?
        @model.attributes.positions[@currentStep] =
          x: "1px"
          y: "1px"
          z: "1"
        @setCurrentPosition()

    setCurrentPosition:->
      @checkStep()
      @model.attributes.positions[@currentStep].x = @$el.css "top"
      @model.attributes.positions[@currentStep].y = @$el.css "left"
      @model.save()

    render: ->
      @$el.draggable()
      @
