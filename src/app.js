const express = require('express')
const myconnection = require('express-myconnection')
const morgan = require('morgan')
const mysql = require('mysql')

const app = express();
app.set('port',4000)

app.use(myconnection(mysql, {
    host: 'localhost',
    user: 'root',
    password: '',
    port: 3306,
    database: 'barber_db'
}))

app.listen(app.get('port'), () =>{
    console.log('API SERVER: ', app.get('port'))
})