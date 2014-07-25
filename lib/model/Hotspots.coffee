define [
  'backbone'
  'underscore'
  'cs!model/Hotspot'
], (Backbone, _, Hotspot)->

  class Hotspots extends Backbone.Collection
    url: window.location.pathname+"/hotspots"
    model: Hotspot
  return new Hotspots
