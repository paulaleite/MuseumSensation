const mongoose = require('mongoose')
const Schema = mongoose.Schema

const Obra = new Schema({
  titulo: {
    type: String
  },
  autor: {
    type: Boolean
  },
  descricao: {
    type: String
  },
  estado: {
      type: Boolean
  },
  imagem: {
      type: String
  }
})


mongoose.model('Obra', Obra)