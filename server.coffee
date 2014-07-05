port = 6166
express = require "express"
ejs = require "ejs"
app = express()
async = require "async"
mongoose = require "mongoose"
Schema = mongoose.Schema

db = mongoose.connect 'mongodb://localhost/pusch360'
fs = require 'fs'

Gallery = mongoose.model 'galleries', new Schema
  dir : String
  steps: []
  hotspots: []
  date: Date

Step = mongoose.model 'steps', new Schema
  dir : String
  image: String
  hotspots: {}

Hotspot = mongoose.model 'hotspots', new Schema
  dir : String
  title : String
  content : String

showGallery = (req, res)->
  dir = req.params.dir
  Gallery.findOne(dir: dir).execFind (err, gallery)->
    return if gallery.length is 0
    gallery = gallery[0]
    Step.find(_id: $in: gallery.steps).execFind (err, steps)->
      Hotspot.find(_id: $in: gallery.hotspots).execFind (err, hotspots)->
        res.send ejs.render fs.readFileSync("./gallery.html", "utf8"),
          config:
            dir: gallery.dir
            steps: steps
            hotspots: hotspots

app.use express.static __dirname+'/'


app.get "/gallery/:dir", showGallery

app.get "/", (req, res)->
  res.sendfile process.cwd()+'/index.html'

app.get "/gallery/:dir/steps", (req, res)->
  Step.find(dir: dir).execFind (err, steps)->
    res.send steps

app.put "/gallery/:dir/steps/:id", (req, res)->
  Step.find(req.params_id).execFind (err, steps)->
    console.log "updateSteps"
    res.send steps

app.get "/gallery/:dir/hotspots", (req, res)->
  Hotspots.find(dir: dir).execFind (err, hotspots)->
    res.send hotspots

app.post "/gallery/:dir/hotspots/:id", (req, res)->
  Hotspots.findById(req.params.id).execFind (err, hotspot)->
    console.log req.body, hotspot
    res.send hotspots

app.put "/gallery/:dir/hotspots/:id", (req, res)->
  Hotspots.findById(req.params.id).execFind (err, hotspot)->
    console.log req.body, hotspot, "updateSteps"
    res.send hotspots

app.delete "/gallery/:dir/hotspots/:id", (req, res)->
  Hotspots.findById(req.params.id).execFind (err, hotspot)->
    console.log req.body, hotspot
    res.send hotspots


app.get "/downloadGallery/:dir", (req, res)->
  Gallery.findOne(dir: req.params.dir).exec (err, gallery)->
      if err
        res.statusCode = 500
        res.end()
      spawn = require("child_process").spawn
      zip = spawn("zip", ["-r", "-", gallery.dir], cwd: "./360images/")
      res.contentType "zip"
      zip.stdout.on "data", (data) -> res.write data
      zip.on "exit", (code) ->
        if code isnt 0
          res.statusCode = 500
        res.end()

app.get "/initGallery/:dir", (req, res)->
  dir = req.params.dir
  gallery = new Gallery()
  Gallery.findOne(dir: dir).execFind (err, galleryExists)->
    if galleryExists.length
      console.log galleryExists, "galleryExists"
      return showGallery req, res

    # save gallery after init
    doneStepping = (err)->
      console.log gallery
      gallery.save ->
        showGallery req, res

    # create new steps for each jpg
    stepping = (file, callback)->
      if file.match(/.jpg/g)
        step = new Step()
        step.dir = dir
        step.image = file
        step.save ->
          gallery.steps.push step._id
          callback()
      else
        callback()

    # new gallery
    gallery.dir = dir
    gallery.date = new Date()
    console.log 'creating new gallery: '+gallery.dir

    dirName = '360images/'+dir+'/'
    fs.readdir dirName, (err, files) ->
      return if err
      async.each files, stepping, doneStepping


app.get "/resetGallery/:dir", (req, res)->
  dir = req.params.dir
  Gallery.findOne(dir: dir).execFind (err, gallery)->
    return res.send "gallery doesnt exists" if gallery.length is 0
    gallery = gallery[0]
    Step.find(_id: $in: gallery.steps).execFind (err, steps)->
      for step in steps
        step.remove()
    Hotspot.find(_id: $in: gallery.hotspots).execFind (err, hotspots)->
       for spot in hotspots
        spot.remove()
    gallery.remove()
    res.send("gallery reseted, ready to init again")

app.listen port
console.log "Welcome to Pusch360! server runs on port "+port