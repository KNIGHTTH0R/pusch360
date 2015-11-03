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
  'cs!view/HotspotViewUser'
  'cs!view/HotspotDetailUserView'
], (Backbone, _, $, Steps, Step, StepView, ControlView, Hotspots, Hotspot, HotspotView, HotspotDetailView)->
  class AppView extends Backbone.View

    className: "gallery-container"
    initialize:(args)->
      $.get '/360images/'+args.dir+'/config.json', (config)=>
        unless args.selector
          selector = "gallery-"+Date.now()
          $("body").append "<div id='"+selector+"'></div>"
          args.selector = selector
        $('#'+args.selector).append @$el

        @HotspotViews = []

        control = new Backbone.Model
        control.set
          total: config.steps.length
          current: 1
        controlView = new ControlView model: control
        controlView.on "changeStep", @changeSteps, @

        @$el.append controlView.render().el
        @HotspotDetailView = new HotspotDetailView
        @$el.append("<div class='overlay-container'></div>")
        @Steps = new Steps
        @listenTo @Steps, 'reset', @addAll
        @listenTo Hotspots, 'reset', @addAllHS
        @Steps.reset config.steps
        Hotspots.reset config.hotspots

    addAll: ->
      @stepView = new StepView collection: @Steps
      @$el.append @stepView.render().el

    addOneHS: (model)->
      stepModel = @Steps.first()
      view = new HotspotView model: model, currentStep: stepModel.get("_id")
      view.on "clickModel", (model)=>
        @HotspotDetailView.model = model
        overlay = @$el.find('.overlay-container')
        overlay.html @HotspotDetailView.render().$el
        overlay.show().one "click", -> $(@).hide()


      @HotspotViews.push view
      @$el.append view.render().el

    changeSteps:(stepnumber)->
      @stepView.change stepnumber
      for view in @HotspotViews
        id = @Steps.models[stepnumber-1].get("_id")
        view.changeCurrentStep(id)

    addAllHS: ->
      Hotspots.each @addOneHS, @

