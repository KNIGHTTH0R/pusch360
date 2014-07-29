define [
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
], (Backbone, _, $, Steps, Step, StepView, ControlView, Hotspots, Hotspot, HotspotView, HotspotDetailView, Template)->
  class AppView extends Backbone.View

    template: _.template Template

    initialize:(args)->

      @$el = $ args.selector
      @$el.append @template()

      @HotspotViews = []

      control = new Backbone.Model
      control.set
        total: args.config.steps.length
        current: 1
      controlView = new ControlView model: control
      controlView.on "changeStep", @changeSteps, @

      @$el.find(".gallery-container").append controlView.render().el
      @Steps = new Steps
      @listenTo @Steps, 'reset', @addAll
      @listenTo Hotspots, 'reset', @addAllHS
      @Steps.reset args.config.steps
      Hotspots.reset args.config.hotspots

    addAll: ->
      @stepView = new StepView collection: @Steps
      @$el.find('.steps').append @stepView.render().el

    addOneHS: (model)->
      stepModel = @Steps.first()
      view = new HotspotView model: model, currentStep: stepModel.get("_id")
      view.on "editHotspot", @switchHotspotDetailView, @
      @HotspotViews.push view
      @$el.find('.hotspots').append view.render().el

    switchHotspotDetailView:(hotspot)->
      @hotspotDetailView.model = hotspot
      @hotspotDetailView.render()
      @hotspotDetailView.showOverlay()

    changeSteps:(options)->
      @stepView.change options.stepnumber
      for view in @HotspotViews
        view.changeCurrentStep(options.stepId)

    addAllHS: ->
      hotspotModel = Hotspots.first()
      unless hotspotModel?
        hotspotModel = new Hotspot
      @hotspotDetailView = new HotspotDetailView model: hotspotModel
      @hotspotDetailView.on "addHotspot", @addOneHS, @
      Hotspots.each @addOneHS, @

  for key, plugin of window.Pusch360Plugins
    new AppView
      selector: plugin.selector
      config: plugin.config
