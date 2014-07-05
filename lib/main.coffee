require [
  'backbone'
  'underscore'
  'jquery'
  'less!/main.less'
], (Backbone, _, $)->

  class Hotspot extends Backbone.Model
    defaults:
      title:"hotspot1"

  class Hotspots extends Backbone.Collection
    url: "hotspots"
    model: Hotspot

  class HotspotView extends Backbone.View
    className: "hotspot"
    template: _.template '<div class="<%= title %>"><h1><%= title %></h1><p><%= content %></p></div>'
    render: ->
      @$el.html @template @model.toJSON()
      @

  class Step extends Backbone.Model

  class Steps extends Backbone.Collection
    url: "steps"
    model: Step

  class StepView extends Backbone.View
    className: "step"
    template: _.template '<img src="/360images/<%= dir %>/<%= image %>" />'
    render: ->
      @$el.html @template @model.toJSON()
      @

  class AppView extends Backbone.View

    initialize:(args)->
      @el = $ args.selector
      @Steps = new Steps
      @Hotspots = new Hotspots
      @listenTo @Steps, 'reset', @addAll
      @listenTo @Hotspots, 'reset', @addAllHS
      @Steps.reset args.config.steps
      @Hotspots.reset args.config.hotspots
      input = $ '<input class="pusch360control" type="range" step="1" value="0" min="0" max="'+@Steps.models.length+'" />'
      input.on 'mousemove change', el: @el, @changeRange
      # @el.on 'change', @
      @el.parent().append input

    changeRange:(e)->
      val = $(e.target).val() || 1
      topelement = e.data.el.find(":nth-child("+val+")");
      if topelement.hasClass "active" then return
      e.data.el.find(".step").removeClass("active").hide()
      # e.data.e.trigger "change"
      topelement.addClass().show()

    addOne: (model)->
      view = new StepView model: model
      @el.append view.render().el

    addAll: ->
      @Steps.each @addOne, @

    addOneHS: (model)->
      view = new HotspotView model: model
      @el.append view.render().el

    addAllHS: ->
      @Hotspots.each @addOneHS, @

  for key, plugin of window.Pusch360Plugins
    new AppView
      selector: plugin.selector
      config: plugin.config

  return "i'm completly fine"
