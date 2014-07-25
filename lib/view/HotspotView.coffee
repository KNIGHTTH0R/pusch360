define [
  'backbone'
  'underscore'
  'text!templates/hotspot.html'
], (Backbone, _, Template)->
  class HotspotView extends Backbone.View
    className: "hotspot"

    initialize:(args) ->
      @rePosition()
      @$el.bind "dragstop", @setCurrentPosition.bind(@)
      @$el.bind "dblclick", @edit.bind(@)
      # @$el.bind "dblclick", ->
      #   $(@).toggleClass("active")

    template: _.template Template

    edit:->
      @trigger "editHotspot", @model

    changeCurrentStep:(step)->
      @currentStep = step
      @rePosition()

    rePosition:->
      @checkStep()
      @$el.css
        top: @model.attributes.positions[@currentStep].x
        left: @model.attributes.positions[@currentStep].y

    checkStep:->
      unless @model.attributes.positions[@currentStep]?
        @model.attributes.positions[@currentStep] =
          x: "1px"
          y: "1px"

    setCurrentPosition:->
      @checkStep()
      @model.attributes.positions[@currentStep].x = @$el.css "top"
      @model.attributes.positions[@currentStep].y = @$el.css "left"
      @model.save()

    render: ->
      @$el.addClass @model.get "title"
      @$el.html @template @model.toJSON()
      @$el.draggable()
      @
