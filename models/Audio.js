const mongoose = require('mongoose')
const Schema = mongoose.Schema

const Audio = new Schema({
  nome: {
    type: String
  },
  estado: {
    type: Boolean
  },
  curador: {
      type: Boolean
  }
})


mongoose.model('Audio', Audio)