require [
  'backbone'
  'underscore'
], (Backbone, _)->
  class HotspotView extends Backbone.View
    className: "hotspot"

    initialize: ->
      @$el.bind "dragstop", (e)->
        console.log e
      @$el.bind "dblclick", ->
        $(@).toggleClass("active")

    template: _.template '<div><h2><%= title %></h2><p><%= content %></p></div>'

    setPosition:(top, left)->
      @$el.css
        top:top
        left:left

    getPosition:->
      top: @$el.css "top"
      left: @$el.css "left"

    render: ->
      @$el.addClass @model.get "title"
      @$el.html @template @model.toJSON()
      @$el.draggable()
      @