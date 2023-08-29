const express = require('express');
const app = express();
const cors = require('cors');

const jwt = require('jsonwebtoken');
const { pwd } = require('./helpers/.');

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('./helpers/bodyMethods');
const prisma = new PrismaClient();

const port = process.env.PORT || 4000;

require('dotenv').config();

// CONFIG
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(__dirname + '/public'));
app.use(cors());

// MIDDLEWARES

const auth = require('./middlewares/auth');

// ROUTES

const users = require('./routes/users');
const admin = require('./routes/admin');
const actors = require('./routes/actors');
const directors = require('./routes/directors');
const persons = require('./routes/persons');
const bookmarks = require('./routes/bookmarks');
const tickets = require('./routes/tickets');
const adminMovies = require('./routes/adminMovies');
const adminActors = require('./routes/adminActors');
const adminDirectors = require('./routes/adminDirectors');
const adminPersons = require('./routes/adminPersons');
const movies = require('./routes/movies');
const reviews = require('./routes/reviews');

app.get('/', (req, res) => {
    res.json({ code: 200 });
})

app.use('/user', users);

app.use('/movie', movies);

app.use('/person', persons)

app.use('/actor', actors);

app.use('/director', directors);

app.use('/bookmark', bookmarks);

app.use('/ticket', tickets);

app.use('/review', reviews);

app.post('/admin/login', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 400, message: 'Datos incompletos.' }) ;
    }

    const newUser = await prisma.admin.findFirst({ where: { username: req.body.username } });

    if (!newUser) {
        return res.json({ code: 400, message: 'Contraseña o usuario incorrecto.' });
    }

    const auth = pwd.dehash(req.body.password, newUser.password);

    if (auth) {
        const token = jwt.sign({ username: newUser.username, email: newUser.email, role: 'admin' }, process.env.JWT_KEY);

        return res.json({ code: 200, message: '¡Inicio de sesión exitoso!', token, username: newUser.username, email: newUser.email, role: 'admin' })
    }
    
    return res.json({ code: 404, message: 'Usuario o contraseña incorrecta.' })
})

app.use(auth);

app.use('/admin', admin);

app.use('/admin/movie', adminMovies);

app.use('/admin/person', adminPersons);

app.use('/admin/actor', adminActors);

app.use('/admin/director', adminDirectors);

//ROUTES

app.listen(port, () => {
    console.log(`Server is running on port ${port}...`);
})