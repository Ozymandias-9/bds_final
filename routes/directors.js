const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

router.post('/search', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 200, data: [] });
    }

    const directors = await prisma.director.findMany({ where: { fullname: { contains: req.body.search } } });

    return res.json({ code: 200, data: directors });
})

module.exports = router;