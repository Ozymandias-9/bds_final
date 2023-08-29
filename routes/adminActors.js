const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/', async (req, res) => {
    if (missingFields(req.body) || Object.keys(req.body).length == 0) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const actorBody = req.body;

    actorBody.birthdate = new Date(actorBody.birthdate);

    const newActor = await prisma.actor.create({ data: actorBody });

    res.json({ code: 200, message: '¡Actor agregado correctamente!', data: newActor })
})

module.exports = router;