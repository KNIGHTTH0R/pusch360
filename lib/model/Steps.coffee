require [
  'backbone'
  'underscore'
], (Backbone, _)->
  class Steps extends Backbone.Collection
    url: "steps"
    model: Step
