require [
  'backbone'
  'underscore'
], (Backbone, _)->
  class Step extends Backbone.Model
    idAttribute: '_id'