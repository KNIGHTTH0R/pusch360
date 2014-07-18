require [
  'backbone'
  'underscore'
], (Backbone, _)->

  class Hotspot extends Backbone.Model
    idAttribute: '_id'
    defaults:
      title: "hotspot1"
      content:"<h1>html content</h1>"