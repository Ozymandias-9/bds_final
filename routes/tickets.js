const express = require('express');
const router = express.Router();

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

function getRentExpiration() {
    var result = new Date();
    result.setDate(result.getDate() + 7);
    return result;
}

function getBuyExpiration() {
    var result = new Date();
    result.setFullYear(result.getFullYear() + 100);
    return result;
}

router.post('/', async (req, res) => {
    const { type } = req.body;
    if (missingFields(req.body)) {
        return res.json({ code: 200, data: [] });
    }

    const ticketExpirationDate = type == 'buy' || type == 'saved' ? getBuyExpiration() : getRentExpiration()

    const ticket = await prisma.ticket.create({
        data: {
            type: type,
            movieId: req.body.movieId,
            userId: req.body.userId,
            createdAt: new Date(),
            expirationDate: ticketExpirationDate
        }
    });

    return res.json({ code: 200, data: ticket, message: `¡${type == 'buy' ? 'Compra' : 'Renta'} realizada correctamente!` });
})

module.exports = router;