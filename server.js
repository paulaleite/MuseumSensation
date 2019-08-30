const express = require('express')
const fs = require('fs')
const getStat = require('util').promisify(fs.stat)
require('./models/index')
const mongoose = require('mongoose')
const Audio = mongoose.model('Audio')
const Obra = mongoose.model('Obra')
const multer = require('multer')


const app = express()

app.use(express.static('public'))
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

//Multer
var Storage = multer.diskStorage({
    destination: function (req, file, callback) {
        callback(null, "./public/audio");
    },
    filename: function (req, file, callback) {
        callback(null, file.originalname);
    }
});

var upload = multer({
    storage: Storage
}).array("imgUploader", 3)

//ROUTES
// 10 * 1024 * 1024 // 10MB
// usamos um buffer minúsculo! O padrão é 64k
const highWaterMark = 1024

app.get('/api', (req, res)=>{
    res.send('Funfando')
})

// Pega o audio pelo nome -> Funcionando
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

// Faz o upload do audio -> Funcionando
app.post("/upload", function (req, res) {
    try {
        upload(req, res, function (err) {
            if (err) {
                return res.json({ result: false });
            }
            return res.json({ result: true });
        });
    } catch (err) {
        console.log(err)
        return res.json({ result: false });
    }

});

// Retorna os audios de uma obra -> Funcionando
app.get('/audios/:id', async (req, res) => {
    let obra = await Obra.findById(req.params.id)

    if (obra) {
        res.json(obra.audios)
    } else {
        res.json({result: false});
    }

})

// Cria um audio dentro de uma obra -> Funcionando
app.post('/createAudio', async (req, res) => {
    let obra = await Obra.findById(req.body.id)

    try {
        if(obra) {
            let newAudio = await Audio.create(req.body.audio)
            if (obra.audios) {
                obra.audios.addToSet(newAudio.id)
            } else {
                obra.audios = newAudio.id
            }
            await obra.save()
            res.json({result: true})
        }
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

// Fornece um update quando 
app.post('/updateAudio', async (req, res) => {
    let obra_id = req.body.id
    let obra = Obra.findById({_id: obra_id})

    try {
        if(obra) {
            let audio_id = req.body.audioId
            let audio = Audio.findById({_id: audio_id})
            if(audio) {
                audio.isAproved = req.body.isAproved
                audio.isCurador = req.body.isCurador
                await audio.save()
                await obra.save()
                res.json({return: true})
            }
            
        }
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }

})

// Deleta um audio com um id especifico -> Funcionando
app.delete('/deleteAudio/:id', async (req, res) => {

    try {
        let idAudio = req.params.id
        await Audio.findByIdAndRemove(idAudio)

        res.json(true)

    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

// Cria uma Obra nova -> Funcionando
app.post('/createObra', async (req, res) => {
    try {
        let newObra = new Obra(req.body)
        await newObra.save()
        // await Obra.create(req.body)
        res.json(true)
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
    
})

// Retorna uma Obra -> Funcionando
app.get('/obra/:id', async (req, res)  => {
    try {
        let obra = await Obra.findById(req.params.id)
        res.json(obra)

    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

// Retorna as Obras -> Funcionando
app.get('/obras', async (req, res) => {
    let obras = await Obra.find({})
    res.json(obras)
})

// Faz um update da obra quando algo for alterado
app.post('/updateObra/:id', async (req, res) => {
    //let obra = await Obra.findById(req.params.id)
    try {
        await Obra.findByIdAndUpdate(req.params.id, req.body)
        res.json(true)
    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

// Deleta um Obra -> Funcionando
app.delete('/deleteObra/:id', async (req, res) => {
    try {
        let idObra = req.params.id
        await Obra.findByIdAndRemove(idObra)

        res.json(true)

    } catch (err) {
        console.log('Error: ', err)
        res.json(false)
    }
})

app.listen(process.env.PORT || 3000, () => console.log('Listening na port 3000'))