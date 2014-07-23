define [
  'backbone'
  'underscore'
  'text!/lib/templates/controls.html'
], (Backbone,_, Template)->
  class ControlView extends Backbone.View
    el: ".controls"

    events:
      "click .prev-step": "prevStep"
      "click .next-step": "nextStep"
      "keyup .jumpto": "jumpTo"
      "mousemove .rangeControl": "range"

    render:->
      @$el.html _.template Template, @model.toJSON() 
    
    initialize:(args)->
      # @model.on "change", @render, @
      @render()
    
    prevStep:->
      changefrom = parseInt(@model.get("current")) 
      @changeStep changefrom-1
    
    nextStep:->
      changefrom = parseInt(@model.get("current")) 
      @changeStep changefrom+1
      
    range:->
      el = @$el.find(".rangeControl")
      # return if el.val() is @model.get("current")
      # if el.val() is parseInt(@model.get("total"))+1
      #   el.val(1)
      # if el.val() is 0
        # el.val(@model.get("total"))
      @changeStep el.val()

    jumpTo:->
      @changeStep @$el.find(".jumpto").val()

    changeStep:(stepNumber)->
      total = parseInt(@model.get("total"))
      if stepNumber < 1 then stepNumber = total
      if stepNumber > total then stepNumber = 1
      @model.set "current", stepNumber
      @$el.find(".jumpto").val(stepNumber)
      @$el.find(".rangeControl").val(stepNumber)
      topelement = @$el.parent().find(".step")[stepNumber-1]
      @trigger "changeStep", $(topelement).attr "step-id"
