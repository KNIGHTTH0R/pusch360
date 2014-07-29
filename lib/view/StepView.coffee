define [
  'backbone'
  'underscore'
], (Backbone, _)->
  class StepView extends Backbone.View

    tagName: "img"

    initialize:(args)->
      @images = []
      that = @
      @collection = args.collection
      @collection.forEach (model)->
        img = new Image()
        img.src = '/360images/'+model.get("dir")+'/'+model.get("thumbnail")
        that.images.push img

      @model = @collection.first()

    change:(stepnumber)->
      @$el.attr("src", @images[parseInt(stepnumber)-1].src);

    render: ->
      @$el.attr "src", '/360images/'+@model.get("dir")+'/' + @model.get "thumbnail"
      @$el.attr "step-id", @model.get "_id"
      @
