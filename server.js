const express = require('express')
const fs = require('fs')
const getStat = require('util').promisify(fs.stat)

const mongoose = require('mongoose')
const Audio = mongoose.model('Audio')
const Obra = mongoose.model('Obra')

require('./models/Index')

const app = express()

app.use(express.static('public'))


//ROUTES
// 10 * 1024 * 1024 // 10MB
// usamos um buffer minúsculo! O padrão é 64k
const highWaterMark = 1024

app.get('/audio/:nome', async (req, res) => {
    try {
        const filePath = `./public/audio/${req.params.nome}`
        const stat = await getStat(filePath)
        // file info

        res.writeHead(200, {
            'Content-Type': 'audio/mp3',
            'Content-Length': stat.size
        })
        //min the trafic
        const stream = fs.createReadStream(filePath, {
            highWaterMark
        })
        // end
        stream.on('end', () => console.log('end'))
        // stream
        stream.pipe(res)
    } catch (error) {
        console.log('Deu erro ao abrir o arquivo.')
        res.json(false)
    }

})


app.get('/audios', async (req, res) => {
    let audios = await Audio.find({})
    res.json(audios);
})

app.post('/createAudio', async (req, res) => {

})

app.put('/updateAudio', async (req, res) => {

})

app.delete('/deleteAudio', async (req, res) => {
    try {
        let idAudio = req.body._id
        await Audio.findByIdAndRemove(idAudio)

        res.json(true)

    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

app.post('/createObra', async (req, res) => {

})

app.get('/obra/:id', async (req, res)  => {
    try {
        let obra = await Obra.findById(req.body._id)
        res.json(obra)

    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

app.get('/obras', async (req, res) => {
    let obras = await Obra.find({})
    res.json(obras);
})

app.put('/updateObra', async (req, res) => {

})

app.delete('/deleteObra', async (req, res) => {
    try {
        let idObra = req.body._id
        await Obra.findByIdAndRemove(idObra)

        res.json(true)

    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

app.listen(process.env.PORT || 3000, () => console.log('Listening na port 3000'))