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

    template: _.template Template

    render:->
      @$el.html @template @model.toJSON()
      @

    initialize:(args)->
      console.log
      # @model.on "change", @render, @
      # @render()

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
      console.log "jumpto"
      @changeStep @$el.find(".jumpto").val()

    changeStep:(stepNumber)->
      total = parseInt(@model.get("total"))
      if stepNumber < 1 then stepNumber = total
      if stepNumber > total then stepNumber = 1
      @model.set "current", stepNumber
      @$el.find(".jumpto").val(stepNumber)
      @$el.find(".rangeControl").val(stepNumber)
      topelement = @$el.parent().parent().find(".step")[stepNumber-1]

      @trigger "changeStep", $(topelement).attr "step-id"
