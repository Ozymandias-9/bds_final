const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 200, data: [] });
    }

    const review = await prisma.review.create({
        data: req.body
    });

    return res.json({ code: 200, message: '¡Reseña subida correctamente!', data: review });
})

module.exports = router;