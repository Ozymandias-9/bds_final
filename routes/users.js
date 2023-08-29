const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const { pwd } = require('../helpers/.');

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

const esDescriptions = { username: 'nombre de usuario', email: 'correo electrónico', phone: 'teléfono' };

router.get('/:username', async (req, res) => {
    if (!req.params.username) {
        return res.json({ code: 400, message: 'Ruta desconocida.' }) ;
    }

    const userData = await prisma.user.findFirst({ 
        where: { username: req.params.username },
        select: { name: true, lastname: true, username: true, email: true, phone: true, cards: true, reviews: true }
    });

    res.json({ code: 200, data: userData });
})

router.post('/register', async (req, res) => {    
    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const userBody = Object.assign({}, req.body, { password: pwd.hash(req.body.password) });

    let user;

    try {
        user = await prisma.user.create({ data: userBody });
    }
    catch (e) {
        if (e.code == 'P2002') {
            return res.json({ code: 500, message: `Ya existe un usuario con ese ${ esDescriptions[e.meta.target.split('_')[1]] }.` })
        }
    }

    const token = jwt.sign({ username: userBody.username, email: userBody.email }, process.env.JWT_KEY);

    return res.json({ code: 200, message: '¡Usuario registrado correctamente!', token, username: userBody.username, email: userBody.email, id: user.id })
})

router.post('/login', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const newUser = await prisma.user.findFirst({ where: { username: req.body.username } });

    const auth = pwd.dehash(req.body.password, newUser.password);

    if (auth) {
        const token = jwt.sign({ username: newUser.username, email: newUser.email, id: newUser.id, role: 'user' }, process.env.JWT_KEY);

        return res.json({ code: 200, message: '¡Inicio de sesión exitoso!', token, username: newUser.username, email: newUser.email, id: newUser.id })
    }
    
    return res.json({ code: 404, message: 'Usuario o contraseña incorrecta.' })
})

router.post('/verify', async (req, res) => {
    let token;

    try {
        token = jwt.verify(req.body.token, process.env.JWT_KEY);
    }
    catch (e) {
        return res.json({ code: 400, message: 'Token no válido.' });
    }

    return res.json({ code: 200, message: `Token válido, ¡bienvenido ${token.username}!`, username: token.username, email: token.email, role: token.role, id: token.id })
})

router.patch('/:username', async (req, res) => {
    if (!req.params.username) {
        return res.json({ code: 400, message: 'Ruta desconocida.' }) ;
    }

    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const userData = await prisma.user.update({ 
        where: { username: req.params.username },
        data: req.body,
        select: { name: true, lastname: true, username: true, email: true, phone: true }
    });

    const { name, lastname, username, email, phone } = userData;

    res.json({ code: 200, message: '¡Usuario actualizado correctamente!', data: { name, lastname, username, email, phone } });
})

router.post('/:username/card', async (req, res) => {
    if (!req.params.username) {
        return res.json({ code: 400, message: 'Ruta desconocida.' }) ;
    }

    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const newCards = await prisma.user.update({
        where: {
            username: req.params.username
        },
        data: {
            cards: {
                create: req.body
            },
        },
        select: { cards: true }
    })

    res.json({ code: 200, message: '¡Tarjeta agregada correctamente!', data: newCards.cards });
})

router.delete('/:username/card/:cardid', async (req, res) => {
    if (!req.params.username || !req.params.cardid) {
        return res.json({ code: 400, message: 'Ruta desconocida.' }) ;
    }

    const newCards = await prisma.user.update({
        where: {
            username: req.params.username
        },
        data: {
            cards: {
                delete: {
                    id: parseInt(req.params.cardid),
                }
            },
        },
        select: { cards: true }
    })

    res.json({ code: 200, message: '¡Tarjeta eliminada correctamente!', data: newCards.cards });
})

module.exports = router;