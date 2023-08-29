const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const directorBody = req.body;

    directorBody.birthdate = new Date(directorBody.birthdate);

    const newDirector = await prisma.director.create({ data: directorBody });

    res.json({ code: 200, message: '¡Director agregado correctamente!', data: newDirector })
})

module.exports = router;