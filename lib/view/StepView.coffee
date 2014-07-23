define [
  'backbone'
  'underscore'
  'text!templates/step.html'
], (Backbone, _, Template)->
  class StepView extends Backbone.View
    template: _.template Template
    initialize:->
      @$el.find(".step").hide()
      @model.on "change", @toggle, @

    toggle:->
      console.log @model, @$el.find(".step")
      if @model.get "active"
        @$el.find(".step").show()
      else
        @$el.find(".step").hide()

    render: ->
      @$el.html @template @model.toJSON()
      @
