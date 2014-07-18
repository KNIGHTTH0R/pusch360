require [
  'backbone'
  'underscore'
  'jquery'
  '../model/Steps'
  '../model/Step'
  '../view/StepView'
  '../model/Hotspots'
  '../model/Hotspot'
  '../view/HotspotView'
  'jquery.ui'
  'less!/main.less'
], (Backbone, _, $, Steps, Step, StepView, Hotspot, Hotspots, HotspotView)->

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
      @HotspotViews = []
      @el = $ args.selector
      @Steps = new Steps
      @Hotspots = new Hotspots
      @listenTo @Steps, 'reset', @addAll
      @listenTo @Hotspots, 'reset', @addAllHS
      @Steps.reset args.config.steps
      @Hotspots.reset args.config.hotspots
      input = $ '<input class="pusch360control" type="range" step="1" value="1" min="1" max="'+@Steps.models.length+'" />'
      input.on 'mousemove change', {el: @el, steps: @Steps}, @changeRange
      @el.parent().prepend input

    changeRange:(e)->
      val = $(e.target).val()

      topelement = e.data.el.find ":nth-child("+val+")"
      return if topelement.hasClass "active"

      step = e.data.steps.findWhere _id: topelement.attr "step-id"
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
      @HotspotViews.push view
      $('#hotspots').append view.render().el

    addAllHS: ->
      @Hotspots.each @addOneHS, @

  for key, plugin of window.Pusch360Plugins
    new AppView
      selector: plugin.selector
      config: plugin.config
