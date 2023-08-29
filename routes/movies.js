const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');

const { PrismaClient } = require('@prisma/client');
const { missingFields } = require('../helpers/bodyMethods');
const prisma = new PrismaClient();

function getTokenInfo(authToken) {
    let token;

    try {
        token = jwt.verify(authToken, process.env.JWT_KEY);

        return token;
    }
    catch (e) {
        return null;
    }
}

// router.get('/test', async (req, res) => {
//     const bestMovies = await prisma.$queryRaw`SELECT * FROM BestMovies`;

//     res.json({ code: 200, data: bestMovies });
// })

router.get('/categories', async (req, res) => {
    const categories = await prisma.category.findMany();

    res.json({ code: 200, data: categories })
})

router.get('/categoriesWithMovies', async (req, res) => {
    const reviews = await prisma.review.groupBy({
        by: ['movieId'],
        _avg: {
            grade: true,
        },
        having: {
            grade: {
                _avg: {
                    gte: 4.5
                }
            }
        }
    })

    const categories = await prisma.category.findMany({
        include: {
            movies: {
                include: {
                    director: true
                }
            }
        }
    });

    const categoriesComplete = categories.map(category => {
        const newMovies = category.movies.map(movie => {
            const grade = reviews.find(el => el.movieId == movie.id);

            if (grade) {
                return Object.assign({}, movie, { grade: grade._avg.grade });                
            }
            else {
                return Object.assign({}, movie, { grade: 0 });
            }
        })

        return Object.assign({}, category, { movies: newMovies });
    })

    console.log(categoriesComplete);

    res.json({ code: 200, data:  categoriesComplete})
})

router.post('/search', async (req, res) => {
    if (missingFields(req.body)) {
        return res.json({ code: 200, data: [] });
    }

    const movies = await prisma.movie.findMany({ where: { title: { contains: req.body.search } } });

    return res.json({ code: 200, data: movies });
})

router.get('/best', async (req, res) => {
    const reviews = await prisma.review.groupBy({
        by: ['movieId'],
        _avg: {
            grade: true,
        },
        having: {
            grade: {
                _avg: {
                    gte: 4.5
                }
            }
        }
    })

    const bestMovies = await prisma.movie.findMany({
        where: {
            id: {
                in: reviews.map((review) => {
                    return review.movieId
                })
            }
        },
        include: {
            director: true
        }
    })

    const bestMoviesComplete = bestMovies.map(movie => {
        const grade = reviews.find(el => el.movieId == movie.id);

        return Object.assign({}, movie, { grade: grade._avg.grade });
    })

    return res.json({ code: 200, data: bestMoviesComplete });
})

router.get('/my-movies', async (req, res) => {
    const token = getTokenInfo(req.headers.auth);

    if (!token) {
        res.json({ code: 400, message: 'Token no válido.' });
    }

    const tickets = await prisma.ticket.findMany({ 
        where: { 
            userId: token.id,
            AND: [
                {
                    NOT: {
                        movieId: {
                            equals: null
                        },
                    },
                },
                {
                    NOT: {
                        type: {
                            equals: 'saved',
                        }
                    },
                }
            ]
        },
        include: {
            movie: true
        }
    });

    res.json({ code: 400, data: tickets });
})

router.get('/bookmarked', async (req, res) => {
    const token = getTokenInfo(req.headers.auth);

    if (!token) {
        res.json({ code: 400, message: 'Token no válido.' });
    }

    const tickets = await prisma.ticket.findMany({ 
        where: { 
            userId: token.id,
            type: {
                equals: 'saved',
            },
            NOT: {
                movieId: null,
            },
        },
        include: {
            movie: true
        }
    });

    res.json({ code: 400, data: tickets });
})

router.get('/:id', async (req, res) => {
    const movie = await prisma.movie.findFirst({ 
        where: { id: parseInt(req.params.id) },
        include: {
            actors: true,
            director: true,
        }
    });

    if (!movie) {
        return res.json({ code: 404, message: 'Película no encontrada.' });
    }

    return res.json({ code: 200, data: movie });
})

router.get('/:id/withTickets', async (req, res) => {
    if (isNaN(req.params.id)) {
        return res.json({ code: 404, message: 'Película no encontrada.' });
    }

    let token;

    try {
        token = jwt.verify(req.headers.auth, process.env.JWT_KEY);
    }
    catch (e) {
        console.log(e);
        return res.json({ code: 400, message: 'Token no válido.' });
    }

    const movie = await prisma.movie.findFirst({ 
        where: { id: parseInt(req.params.id) },
        select: {
            id: true,
            categoryId: true,
            photo: true,
            title: true,
            premiereDate: true,
            classification: true,
            duration: true,
            buyPrice: true,
            rentPrice: true,
            directorId: true,
            synopsis: true,
            category: true,
            actors: true,
            director: true,
            tickets: {
                where: {
                    userId: token.id
                }
            }
        }
    });

    const aggregation = await prisma.review.aggregate({
        where: {
            movieId: movie.id
        },
        _avg: {
            grade: true
        },
    })

    if (!movie) {
        return res.json({ code: 404, message: 'Película no encontrada.' });
    }

    return res.json({ code: 200, data: Object.assign({}, movie, { grade: aggregation._avg.grade == null ? 0 : aggregation._avg.grade.toFixed(1) }) });
})

module.exports = router;