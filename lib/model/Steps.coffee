define [
  'backbone'
  'underscore'
  'cs!model/Step'
], (Backbone, _, Step)->
  class Steps extends Backbone.Collection
    url: window.location.pathname+"/steps"
    model: Step
