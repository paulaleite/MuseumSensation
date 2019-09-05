const mongoose = require('mongoose')
const Schema = mongoose.Schema
const autopopulate = require('mongoose-autopopulate');

const Obra = new Schema({
    beacon: {
        type: Int
    },
    titulo: {
        type: String,
        required: true
    },
    autor: {
        type: String,
        required: true
    },
    descricao: {
        type: String
    },
    estado: {
        type: Boolean
    },
    imagem: {
        type: String
    }, 
    audios: [{ // Aqui sera feito o relacionamento
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Audio',
        autopopulate: true // Para passar todos os audios
    }]
}, {
    timestamps: true
})

Obra.plugin(autopopulate)
mongoose.model('Obra', Obra)