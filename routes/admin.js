const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const { pwd } = require('../helpers/.');

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.get('/:username', async (req, res) => {
    if (!req.params.username) {
        return res.json({ code: 400, message: 'Ruta desconocida.' }) ;
    }

    const userData = await prisma.admin.findFirst({ 
        where: { username: req.params.username },
        select: { name: true, lastname: true, username: true, email: true, phone: true }
    });

    res.json({ code: 200, data: userData });
})

router.post('/login', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const newUser = await prisma.admin.findFirst({ where: { username: req.body.username } });

    const auth = pwd.dehash(req.body.password, newUser.password);

    if (auth) {
        const token = jwt.sign({ username: newUser.username, email: newUser.email, role: 'admin' }, process.env.JWT_KEY);

        return res.json({ code: 200, message: '¡Inicio de sesión exitoso!', token, username: newUser.username, email: newUser.email })
    }
    
    return res.json({ code: 404, message: 'Usuario o contraseña incorrecta.' })
})

router.patch('/:username', async (req, res) => {
    if (!req.params.username) {
        return res.json({ code: 400, message: 'Ruta desconocida.' }) ;
    }

    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const userData = await prisma.admin.update({ 
        where: { username: req.params.username },
        data: req.body,
        select: { name: true, lastname: true, username: true, email: true, phone: true }
    });

    const { name, lastname, username, email, phone } = userData;

    res.json({ code: 200, message: '¡Usuario actualizado correctamente!', data: { name, lastname, username, email, phone } });
})

module.exports = router;