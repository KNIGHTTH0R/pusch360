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
  'jquery-ui'
], (Backbone, _, $, Steps, Step, StepView, ControlView, Hotspots, Hotspot, HotspotView, HotspotDetailView)->
  class AppView extends Backbone.View

    className: "gallery-container"

    initialize:(args)->
      $("#"+args.selector).append @$el
      @HotspotViews = []
      control = new Backbone.Model
      control.set
        total: args.config.steps.length
        current: 1
      controlView = new ControlView model: control
      controlView.on "changeStep", @changeSteps, @
      @$el.append controlView.render().el

      @HotspotDetailView = new HotspotDetailView
      @$el.append "<div class='overlay'></div>"
      @$el.find(".overlay").append @HotspotDetailView.render()
      input = $("<input type='button' class='add-hs' value='new hotspot' />").appendTo @$el
      input.on "click", =>
        model = @HotspotDetailView.addHotspot()
        @addOneHS model
      @Steps = new Steps
      @listenTo @Steps, 'reset', @addAll
      @listenTo Hotspots, 'reset', @addAllHS
      @Steps.reset args.config.steps
      Hotspots.reset args.config.hotspots

    addAll: ->
      @stepView = new StepView collection: @Steps
      @$el.append @stepView.render().el

    addOneHS: (model)->
      stepModel = @Steps.first()
      view = new HotspotView model: model, currentStep: stepModel.get("_id")
      view.on "editHotspot", (model)=>
        @HotspotDetailView.changeModel model

      @HotspotViews.push view
      @$el.append view.render().el

    changeSteps:(stepnumber)->
      @stepView.change stepnumber
      for view in @HotspotViews
        id = @Steps.models[stepnumber-1].get("_id")
        view.changeCurrentStep(id)

    addAllHS: ->
      Hotspots.each @addOneHS, @
