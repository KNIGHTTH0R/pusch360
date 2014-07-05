require [
  'backbone'
  'underscore'
  'jquery'
  'jquery.ui'
  'less!/main.less'
], (Backbone, _, $)->

  class Hotspot extends Backbone.Model
    idAttribute: '_id'
    defaults:
      title: "hotspot1"
      content:"<h1>html content</h1>"

  class Hotspots extends Backbone.Collection
    url: window.location.pathname+"/hotspots"
    model: Hotspot

  class HotspotView extends Backbone.View
    className: "hotspot"

    initialize: ->
      @$el.bind "dblclick", ->
        $(@).toggleClass("active")


    template: _.template '<h2><%= title %></h2><p><%= content %></p>'
    render: ->
      @$el.addClass @model.get "title"
      @$el.html @template @model.toJSON()

      @$el.draggable()

      @

  class Step extends Backbone.Model
    idAttribute: '_id'

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

    el:"#app"

    events:
      "click #newHotspot": "newHotspot"

    newHotspot: ->
      that = @
      model = new Hotspot
      model.set
        title: $("#hotspot-title").val()
        content: $("#hotspot-content").val()
      @Hotspots.create model,
        success:->
          that.addOneHS model

    initialize:(args)->
      @el = $ args.selector
      @Steps = new Steps
      @Hotspots = new Hotspots
      @listenTo @Steps, 'reset', @addAll
      @listenTo @Hotspots, 'reset', @addAllHS
      @Steps.reset args.config.steps
      @Hotspots.reset args.config.hotspots
      input = $ '<input class="pusch360control" type="range" step="1" value="1" min="1" max="'+@Steps.models.length+'" />'
      input.on 'mousemove change', el: @el, @changeRange
      @el.parent().prepend input

    changeRange:(e)->
      val = $(e.target).val()
      topelement = e.data.el.find ":nth-child("+val+")"
      return if topelement.hasClass "active"
      e.data.el.find(".step").removeClass("active")
      topelement.addClass('active').show()
      e.data.el.find(".step:not(.active)").hide()
      # e.data.e.trigger "change"

    addOne: (model)->
      view = new StepView model: model
      @el.append view.render().el

    addAll: ->
      @Steps.each @addOne, @

    addOneHS: (model)->
      view = new HotspotView model: model
      $('#hotspots').append view.render().el

    addAllHS: ->
      @Hotspots.each @addOneHS, @

  for key, plugin of window.Pusch360Plugins
    new AppView
      selector: plugin.selector
      config: plugin.config

  return "i'm completly fine"
