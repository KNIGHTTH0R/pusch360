define [
  'backbone'
  'underscore'
  'text!templates/controls.html'
], (Backbone,_, Template)->
  class ControlView extends Backbone.View

    className:'controls'

    events:
      "mousedown .controls-container": "stopProp"
      "click .prev-step": "prevStep"
      "click .next-step": "nextStep"
      "blur .jumpto": "jumpTo"

    template: _.template Template
    stopProp:(e)->
      e.stopPropagation()
    keyupEvent:(e)->
      key = e.keyCode
      if key is 37 then @prevStep() # left cursor
      else if key is 39 then @nextStep()# right cursor

    render:->
      @$el.html @template @model.toJSON()
      @

    initialize:()->
      $(window).on "mouseup", @endSlide.bind(@)
      $(window).on "mousemove", @slideImages.bind(@)
      $(window).on "keyup", @keyupEvent.bind(@)
      @$el.on "mousedown", @startSlide.bind(@)



    tresh: 20

    slideImages: (e)->
      return unless @isDrag
      thisPos = e.pageX || e.screenX
      diff = @dragPos - thisPos
      return unless diff>@tresh || diff<-@tresh
      if diff>0 then @prevStep()
      else @nextStep()
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

    range:(e)->
      elVal = parseInt $(e.target).val()
      return if elVal is @model.get "current"
      @changeStep elVal

    jumpTo:(e)->
      @changeStep $(e.target).val()

    changeStep:(stepNumber)->
      total = parseInt @model.get "total"
      if stepNumber < 1 then stepNumber = total
      if stepNumber > total then stepNumber = 1
      @model.set "current", stepNumber
      @$el.find(".jumpto").val(stepNumber)
      @$el.find(".rangeControl").val(stepNumber)

      @trigger "changeStep", @model.get "current"
