const mongoose = require('mongoose')
const Schema = mongoose.Schema

const Audio = new Schema({
  dados: {
    type: String
  },
  estado: {
    type: Boolean
  },
  nomeObra: {
    type: String
  },
  curador: {
      type: Boolean
  }
})


mongoose.model('Audio', Audio)