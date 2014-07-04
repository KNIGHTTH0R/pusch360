port = 6166
express = require "express"
app = express()
mongoose = require "mongoose"
db = mongoose.connect 'mongodb://localhost/pusch360'
fs = require 'fs'

app.use express.static __dirname+'/'


app.get "/", (req, res)->
  res.sendfile process.cwd()+'index.html'

app.listen port
console.log "Welcome to Pusch360! server runs on port "+port