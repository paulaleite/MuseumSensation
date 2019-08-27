const express = require('express')
const fs = require('fs')
const getStat = require('util').promisify(fs.stat)

require('./models/Index')

const app = express()

app.use(express.static('public'))


//ROUTES
// 10 * 1024 * 1024 // 10MB
// usamos um buffer minúsculo! O padrão é 64k
const highWaterMark = 1024

app.get('/audio/:name', async (req, res) => {
    try {
        const filePath = `./public/audio/${req.params.name}`
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

app.listen(process.env.PORT || 3000, () => console.log('Listening na port 3000'))