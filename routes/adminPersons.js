const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const personType = req.body.personType;
    delete req.body.personType;

    const personBody = req.body;

    personBody.birthdate = new Date(personBody.birthdate);

    const newPerson = await prisma[personType == 0 ? 'actor' : 'director'].create({ data: personBody });

    res.json({ code: 200, message: `¡${personType == 0 ? 'Actor' : 'Director'} agregado correctamente!`, data: newPerson })
})

router.patch('/:type/:id', async (req, res) => {
    const { type, id } = req.params;

    const person = await prisma[type].update({
        data: req.body,
        where: {
            id: parseInt(id)
        },
        include: {
            movies: {
                take: 10,
            }
        }
    })

    if (!person) {
        return res.json({ code: 404, message: 'Persona no encontrada.' });
    }

    return res.json({ code: 200, message: '¡Persona actualizada correctamente!', data: person });
})

router.delete('/:type/:id', async (req, res) => {
    const person = await prisma[req.params.type].delete({
        where: {
            id: parseInt(req.params.id)
        }
    })

    if (!person) {
        return res.json({ code: 404, message: 'Persona no encontrada.' });
    }

    return res.json({ code: 200, message: '¡Persona eliminada correctamente!' });
})

module.exports = router;