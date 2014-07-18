require [
  'backbone'
  'underscore'
], (Backbone, _)->
  class StepView extends Backbone.View
    className: "step"
    template: _.template '<img src="/360images/<%= dir %>/<%= image %>" />'
    initialize:->
      @$el.attr "step-id", @model.get "_id"
    render: ->
      @$el.html @template @model.toJSON()
      @