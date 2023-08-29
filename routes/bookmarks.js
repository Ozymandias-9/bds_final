const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/get', async (req, res) => {
    const bookmark = await prisma.bookmark.findFirst({
        where: {
            movieId: parseInt(req.body.movieId),
            userId: parseInt(req.body.userId),
        }
    });

    return res.json({ code: 200, data: bookmark });
})

router.post('/', async (req, res) => {
    const { type } = req.body;
    if (missingFields(req.body)) {
        return res.json({ code: 200, data: [] });
    }

    const bookmark = await prisma.bookmark.create({
        data: {
            movieId: req.body.movieId,
            userId: req.body.userId,
        }
    });

    return res.json({ code: 200, data: bookmark, message: '¡Película añadida a tus guardados!' });
})

router.delete('/:id', async (req, res) => {
    const bookmark = await prisma.bookmark.delete({
        where: {
            id: parseInt(req.params.id)
        }
    });

    if (!bookmark) {
        return res.json({ code: 404, message: 'Película no encontrada.'});
    }

    return res.json({ code: 200, message: '¡Película eliminada de guardados!'});
})

module.exports = router;