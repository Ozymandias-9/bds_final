const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/search', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 200, data: [] });
    }

    const actors = await prisma.actor.findMany({ where: { fullname: { contains: req.body.search } } });
    const directors = await prisma.director.findMany({ where: { fullname: { contains: req.body.search } } });

    return res.json({ code: 200, data: [...actors.map(x => Object.assign({}, x, { type: 'actor' })), ...directors.map(x => Object.assign({}, x, { type: 'director' }))] });
})

router.get('/:type/:id', async (req, res) => {
    if (isNaN(req.params.id)) {
        return res.json({ code: 404, message: 'Persona no encontrada.' });
    }

    const { type, id } = req.params;

    const person = await prisma[type].findFirst({
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

    return res.json({ code: 200, data: person });
})

module.exports = router;