define [
  'backbone'
  'underscore'
], (Backbone, _)->
  class Step extends Backbone.Model
    idAttribute: '_id'
    defaults:
      active:false
