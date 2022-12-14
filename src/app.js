const express = require('express')
const myconnection = require('express-myconnection')
const bodyParser = require('body-parser')
const mysql = require('mysql')

const app = express()
app.set('port', 4000)

app.listen(app.get('port'), () =>{
    console.log('API corriendo en: ', app.get('port'))
})