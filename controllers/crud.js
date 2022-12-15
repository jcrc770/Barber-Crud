const conexion = require('../database/db');


exports.save=(req,res)=>{
    const nombre=req.body.nombre;
    const telefono=req.body.telefono;
    const servicio=req.body.servicio;
    const fecha=req.body.fecha;
    const hora=req.body.hora;
    const barbero=req.body.barbero;
    conexion.query('INSERT INTO users SET ?',{nombre:nombre,telefono:telefono,servicio:servicio,fecha:fecha,hora:hora,barbero:barbero},(error,results)=>{
        if(error){
            console.log(error);
        }else{
            res.redirect('/');
        }
    })
};

exports.update=(req,res)=>{
    const id=req.body.id;
    const nombre=req.body.nombre;
    const telefono=req.body.telefono;
    const servicio=req.body.servicio;
    const fecha=req.body.fecha;
    const hora=req.body.hora;
    const barbero=req.body.barbero;
    conexion.query('UPDATE users SET ? WHERE id=?',[{nombre:nombre,telefono:telefono,servicio:servicio,fecha:fecha,hora:hora,barbero:barbero},id], (error,results)=>{
        if(error){
            console.log(error);
        }else{
            res.redirect('/');
        }
    })
}
