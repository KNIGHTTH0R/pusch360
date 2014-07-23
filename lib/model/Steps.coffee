define [
  'backbone'
  'underscore'
  'cs!/lib/model/Step'
], (Backbone, _, Step)->
  class Steps extends Backbone.Collection
    url: window.location.pathname+"/steps"
    model: Step
    findActive:->
      finds = @filter (step)->
        step.get "active"
      return finds[0]
