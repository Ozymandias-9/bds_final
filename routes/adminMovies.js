const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/', async (req, res) => {
    const newMovie = await prisma.movie.create({ data: req.body });

    res.json({ code: 200, message: '¡Película creada correctamente!', data: newMovie })
})

router.delete('/:id', async (req, res) => {
    const movie = await prisma.movie.delete({
        where: {
            id: parseInt(req.params.id),
        }
    })

    if (!movie) {
        return res.json({ code: 404, message: 'Película no encontrada.' });
    }

    return res.json({ code: 200, message: '¡Película eliminada correctamente!' });
})

router.patch('/:id', async (req, res) => {
    const movie = await prisma.movie.update({
        data: req.body,
        where: {
            id: parseInt(req.params.id)
        },
        include: {
            actors: true,
            director: true,
        }
    })

    if (!movie) {
        return res.json({ code: 404, message: 'Película no encontrada.' });
    }

    return res.json({ code: 200, message: '¡Película actualizada correctamente!', data: movie });
})


module.exports = router;