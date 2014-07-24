define [
  'backbone'
  'underscore'
  'text!templates/controls.html'
], (Backbone,_, Template)->
  class ControlView extends Backbone.View

    events:
      "click .prev-step": "prevStep"
      "click .next-step": "nextStep"
      "keyup .jumpto": "jumpTo"
      "mousemove .rangeControl": "range"

      "mousedown .slidearea": "startSlide"
      #"mouseout .slidearea": "endSlide"
      "mouseup .slidearea": "endSlide"
      "mousemove .slidearea": "slideImages"
      "dragstart .slidearea": "startSlide"
      "dragend .slidearea": "endSlide"
      "drag .slidearea": "slideImages"

    template: _.template Template

    render:->
      @$el.html @template @model.toJSON()
      @

    initialize:()->
      window.addEventListener "mouseup", @endSlide.bind(@)
      window.addEventListener "mousemove", @slideImages.bind(@)
      # @model.on "change", @render, @
      # @render()

    slideImages: (e)->
      if @isDrag isnt true then return
      tresh = 30
      thisPos = e.pageX || e.screenX
      diff = @dragPos - thisPos
      if diff>tresh
        @prevStep()
        @dragPos = thisPos
      else if diff<-tresh
        @nextStep()
        @dragPos = thisPos
    startSlide: (e)->
      @dragPos = e.pageX || e.screenX
      @isDrag = true
    endSlide: (e)->
      @isDrag = false

    prevStep:->
      changefrom = parseInt @model.get "current"
      @changeStep changefrom-1
    nextStep:->
      changefrom = parseInt @model.get "current"
      @changeStep changefrom+1

    range:->
      elVal = parseInt @$el.find(".rangeControl").val()
      return if elVal is @model.get "current"
      @changeStep elVal

    jumpTo:->
      @changeStep @$el.find(".jumpto").val()

    changeStep:(stepNumber)->
      total = parseInt @model.get "total"
      if stepNumber < 1 then stepNumber = total
      if stepNumber > total then stepNumber = 1
      @model.set "current", stepNumber
      @$el.find(".jumpto").val(stepNumber)
      @$el.find(".rangeControl").val(stepNumber)
      topelement = @$el.parent().parent().find(".step")[stepNumber-1]

      @trigger "changeStep", $(topelement).attr "step-id"
