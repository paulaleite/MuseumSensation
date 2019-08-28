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

//retorna  audios de uma obra
app.get('/audios/:id', async (req, res) => {
    let obra_id = req.params.id
    let obra = Obra.findById({_id: obra_id})

    if (obra) {
        res.json(obra.audios)
    } else {
        res.json({result: false});
    }

})

app.post('/createAudio', async (req, res) => {
    let obra_id = req.body.id
    let obra = Obra.findById({_id: obra_id})

    if(obra){
        let newAudio = new Audio(req.body.audio)
        await newAudio.save()
        if (obra.audios) {
            obra.audios.addToSet(newAudio.id)
        } else {
            obra.audios = newAudio.id
        }
        await obra.save()
        res.json({result : true})
    }
    res.json ({result: false})
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