require [
  'backbone'
  'underscore'
], (Backbone, _)->

  class Hotspots extends Backbone.Collection
    url: window.location.pathname+"/hotspots"
    model: Hotspot
