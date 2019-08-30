const mongoose = require('mongoose')
const Schema = mongoose.Schema

const Audio = new Schema({
  nome: {
    type: String,
    require: true
  },
  isAproved: {
    type: Boolean
  },
  isCurador: {
      type: Boolean
  }
})


mongoose.model('Audio', Audio)