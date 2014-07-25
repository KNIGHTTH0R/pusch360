require [
  'backbone'
  'underscore'
  'jquery'
  'cs!model/Steps'
  'cs!model/Step'
  'cs!view/StepView'
  'cs!view/ControlView'
  'cs!model/Hotspots'
  'cs!model/Hotspot'
  'cs!view/HotspotView'
  'cs!view/HotspotDetailView'
  'text!templates/app.html'
  'jquery-ui'
  'less!style.less'
], (Backbone, _, $, Steps, Step, StepView, ControlView, Hotspots, Hotspot, HotspotView, HotspotDetailView, Template)->
  class AppView extends Backbone.View


    template: _.template Template

    initialize:(args)->
      @$el = $ args.selector
      @$el.append @template()

      @StepViews = []
      @HotspotViews = []

      control = new Backbone.Model
      control.set
        total: args.config.steps.length
        current: 1
      controlView = new ControlView model: control
      controlView.on "changeStep", @changeSteps, @

      @$el.find(".controls").append controlView.render().el
      @Steps = new Steps
      @listenTo @Steps, 'reset', @addAll
      @listenTo Hotspots, 'reset', @addAllHS
      @Steps.reset args.config.steps
      Hotspots.reset args.config.hotspots


    initHotspotDetail: ->

    addOne: (model)->
      if @StepViews.length is 0 then model.set "active", true
      view = new StepView model: model
      @StepViews.push view
      @$el.find('.steps').append view.render().el

    addAll: ->
      @Steps.each @addOne, @

    addOneHS: (model)->
      stepModel = @Steps.first()
      view = new HotspotView model: model, currentStep: stepModel.get("_id")
      view.on "editHotspot", @hotspotDetailView.editHotspot
      @HotspotViews.push view
      @$el.find('.hotspots').append view.render().el

    changeSteps:(step)->
      activeStep = @Steps.findActive()
      newStep = @Steps.findWhere _id: step
      newStep.set("active", true)
      activeStep?.set("active", false)

      for view in @HotspotViews
        view.changeCurrentStep(step)

    addAllHS: ->
      hotspotModel = Hotspots.first()
      unless hotspotModel?
        hotspotModel = new Hotspot
      @hotspotDetailView = new HotspotDetailView model: hotspotModel
      @$el.find(".editHotspot").append @hotspotDetailView.render().el
      Hotspots.each @addOneHS, @

  for key, plugin of window.Pusch360Plugins
    new AppView
      selector: plugin.selector
      config: plugin.config
