require [
  'backbone'
  'underscore'
  'jquery'
], (Backbone, _, $)->

  class Step extends Backbone.Model

  class Steps extends Backbone.Collection
    url: "steps"
    model: Step

  class StepView extends Backbone.View
    template: _.template '<img src="/360images/<%= dir %>/<%= image %>" />'
    render: ->
      @$el.html @template @model.toJSON()
      @

  class AppView extends Backbone.View

    events:
      "change .range":  "changeRange"

    initialize:(args)->
      @el = $ args.selector
      @Steps = new Steps
      @listenTo @Steps, 'reset', @addAll
      @Steps.reset args.config.steps

    init: (selector, config)->

    addOne: (model)->
      view = new StepView model: model
      @el.append view.render().el

    addAll: ->
      @Steps.each @addOne, @

  for key, plugin of window.Pusch360Plugins
    new AppView
      selector: plugin.selector
      config: plugin.config

  return "i'm completly fine"
