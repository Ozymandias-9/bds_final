const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient()

async function main() {
  await prisma.user.create({
    data: {
      email: 'ozymandias@gmail.com',
      name: 'Oscar',
      lastname: 'Melchor',
      username: 'ozymandias',
      phone: '4423746798',
      password: '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW',
      cards: {
        create: {
          fullname: 'Oscar Elí Melchor Hernández',
          cardNumber: '4152 3134 4567 4892',
          cvc: '456',
          expirationTime: '01/25'
        } 
      }
    },
  })

  await prisma.admin.create({
    data: {
      email: 'admin@cineclub.io',
      name: 'Admin',
      lastname: 'Supremo',
      username: 'admin',
      phone: '4461117033',
      password: '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW',
    },
  })

  await prisma.category.createMany({
    data: [
      {
        name: 'Acción',
      },
      {
        name: 'Ciencia Ficción',
      },
      {
        name: 'Comedia',
      },
      {
        name: 'Drama',
      },
      {
        name: 'Musical',
      },
      {
        name: 'Romance',
      },
      {
        name: 'Superhéroes',
      },
      {
        name: 'Terror',
      },
    ]
  })

  await prisma.actor.createMany({
    data: [
      {
        fullname: 'Brad Pitt',
        photo: 'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg',
        birthdate: new Date('1963-12-18 06:00:00.000'),
        birthplace: 'Oklahoma, EEUU.',
        biography: 'William Bradley Pitt, más conocido como Brad Pitt, es un actor, modelo y productor de cine estadounidense.'
      },
      {
        fullname: 'Ryan Gosling',
        photo: 'https://es.web.img2.acsta.net/pictures/16/05/17/17/28/208580.jpg',
        birthdate: new Date('1980-11-12 06:00:00.000'),
        birthplace: 'London, Canadá.',
        biography: 'Ryan Thomas Gosling es un actor canadiense. Destacado en el cine independiente, también ha trabajado en éxitos de taquilla de varios géneros.'
      },
      {
        fullname: 'Timothée Chalamet',
        photo: 'https://e00-telva.uecdn.es/assets/multimedia/imagenes/2021/09/16/16317870417608.jpg',
        birthdate: new Date('1995-12-27 06:00:00.000'),
        birthplace: 'Nueva York, EEUU.',
        biography: 'Timothée Hal Chalamet es un actor estadounidense.​ Ha sido nominado para un Premio Óscar, tres BAFTAs, dos Globo de Oro, cuatro SAG y cinco Premios de la Crítica Cinematográfica.'
      },
      {
        fullname: 'Michelle Yoeh',
        photo: 'https://es.web.img2.acsta.net/pictures/17/09/20/10/22/2250952.jpg',
        birthdate: new Date('1962-08-06 06:00:00.000'),
        birthplace: 'Ipoh, Malasia',
        biography: 'Michelle Yeoh Choo-Khenges una actriz, modelo y bailarina malaya de origen chino. Aprendió inglés, malayo y posteriormente chino.'
      },
	    {
        fullname: 'Jonathan Ke Quan',
        photo: 'https://es.web.img3.acsta.net/pictures/22/04/07/12/12/3497861.jpg',
        birthdate: new Date('1971-08-20 06:00:00.000'),
        birthplace: 'Ho Chi Minh, Vietnam',
        biography: 'Actor y coreógrafo estadounidense nacido en vietnam'
      },
	    {
        fullname: 'Stephanie Hsu',
        photo: 'https://deadline.com/wp-content/uploads/2021/08/Stephanie-Hsu-Headshot-e1629417225251.jpg',
        birthdate: new Date('1962-08-06 06:00:00.000'),
        birthplace: 'California, EEUU',
        biography: 'Stephanie Ann Hsu es una actriz estadounidense de cine, teatro y televisión.'
      },
      {
        fullname: 'Daniel Day-Lewis',
        photo: 'https://m.media-amazon.com/images/M/MV5BMjE2NDY2NDc1Ml5BMl5BanBnXkFtZTcwNjAyMjkwOQ@@._V1_.jpg',
        birthdate: new Date('1957-04-29 06:00:00.000'),
        birthplace: 'Londres, Reino Unido',
        biography: 'Daniel Day-Lewis es un actor retirado británico nacionalizado irlandés.​ Ganador de tres Premios Óscar, aclamado por la crítica y reconocido mundialmente por su talento interpretativo.'
      },
	{
        fullname: 'Paul Dano',
        photo: 'https://m.media-amazon.com/images/M/MV5BMjMwMzE1OTc0OF5BMl5BanBnXkFtZTcwMDU2NTg0Nw@@._V1_.jpg',
        birthdate: new Date('1984-06-19 06:00:00.000'),
        birthplace: 'Nueva York, EEUU',
        biography: 'Paul Franklin Dano es un actor, guionista y director estadounidense.'
      }
    ]
  })

  await prisma.director.createMany({
    data: [
      {
        fullname: 'Denis Villeneuve',
        photo: 'https://www.themoviedb.org/t/p/w500/zdDx9Xs93UIrJFWYApYR28J8M6b.jpg',
        birthdate: new Date('1967-10-03 06:00:00.000'),
        birthplace: 'Quebec, Canadá.',
        biography: 'Denis Villeneuve es un guionista y director de cine canadiense. Fue nominado a un premio Óscar en la categoría de mejor dirección por su película La llegada, y ha ganado tres premios Genie.'
      },
      {
        fullname: 'David Fincher',
        photo: 'https://images.mubicdn.net/images/cast_member/1469/cache-103636-1599486038/image-w856.jpg',
        birthdate: new Date('1962-08-28 06:00:00.000'),
        birthplace: 'Colorado, EEUU.',
        biography: 'David Andrew Leo Fincher​​, conocido como David Fincher, es un director y productor estadounidense de cine, televisión y vídeos musicales.'
      },
      {
        fullname: 'Dan Kwan',
        photo: 'https://m.media-amazon.com/images/M/MV5BMjJiZjk1YzAtNGI1Ny00MWE5LWFkMGMtOGRmY2FlNDg4Zjg2XkEyXkFqcGdeQXVyMTExNDQ2MTI@._V1_.jpg',
        birthdate: new Date('1988-10-02 06:00:00.000'),
        birthplace: 'Massachusetts, EEUU.',
        biography: 'Director de Cine'
      },
      {
        fullname: 'Paul Thomas Anderson',
        photo: 'https://indiehoy.com/wp-content/uploads/2022/12/paul-thomas-anderson.jpg',
        birthdate: new Date('1970-06-26 06:00:00.000'),
        birthplace: 'California EEUU',
        biography: 'Paul Thomas Anderson es un director, guionista y productor de cine estadounidense.'
      },
    ]
  })

  await prisma.movie.createMany({
    data: [
      {
        title: 'Blade Runner 2049',
        premiereDate: 2017,
        photo: 'https://fotografias.flooxernow.com/clipping/cmsimages01/2017/10/03/731B1AAD-0130-44BA-ADD0-1D221A75D367/69.jpg',
        classification: 'B',
        duration: '139 mins',
        buyPrice: 150,
        rentPrice: 50,
        categoryId: 2,
        synopsis: "Han pasado 30 años desde los acontecimientos ocurridos en Blade Runner (1982). El agente K (Ryan Gosling), un 'blade runner' caza-Replicantes del Departamento de Policía de Los Ángeles, descubre un secreto que ha estado enterrado durante mucho tiempo y que tiene el potencial de llevar a la sociedad al caos. Su investigación le conducirá a la búsqueda del legendario Rick Deckard (Harrison Ford), un antiguo blade runner en paradero desconocido, que lleva desaparecido 30 años.",
        directorId: 1,
      },
      {
        title: 'Duna',
        premiereDate: 2020,
        photo: 'https://media.thegospelcoalition.org/wp-content/uploads/sites/4/2021/11/25123704/Duna-pelicula.jpeg',
        classification: 'B',
        duration: '139 mins',
        buyPrice: 150,
        rentPrice: 50,
        categoryId: 2,
        synopsis: "Arrakis, también denominado 'Dune', se ha convertido en el planeta más importante del universo. A su alrededor comienza una gigantesca lucha por el poder que culmina en una guerra interestelar.",
        directorId: 1,
      },
      {
        title: 'El Club de la Pelea',
        premiereDate: 1999,
        photo: 'https://i0.wp.com/blog.rebelionantigua.com/wp-content/uploads/2007/12/El-club-de-la-pelea-y-el-significado-de-la-vida.png',
        classification: 'C',
        duration: '139 mins',
        buyPrice: 150,
        rentPrice: 50,
        categoryId: 1,
        synopsis: "Un empleado de oficina insomne, harto de su vida, se cruza con un vendedor peculiar. Ambos crean un club de lucha clandestino como forma de terapia y, poco a poco, la organización crece y sus objetivos toman otro rumbo.",
        directorId: 2,
      },
      {
        title: 'Todo En Todas Partes Al Mismo Tiempo',
        premiereDate: 2022,
        photo: 'https://static.cinepolis.com/resources/mx/movies/posters/414x603/39349-815954-20220512044043.jpg',
        classification: 'B',
        duration: '139 mins',
        buyPrice: 150,
        rentPrice: 50,
        categoryId: 5,
        synopsis: "Una heroína inesperada debe usar sus nuevos poderes para luchar contra los desconcertantes peligros del multiverso y así lograr salvar su mundo.",
        directorId: 3,
      },
      {
        title: 'Petróleo sangrientoo',
        premiereDate: 2007,
        photo: 'https://assets.nflxext.com/us/boxshots/hd1080/70075473.jpg',
        classification: 'B-15',
        duration: '158 mins',
        buyPrice: 150,
        rentPrice: 50,
        categoryId: 4,
        synopsis: "La historia de un buscador de petróleo de Texas y los problemas que enfrenta en el negocio al comienzo del nuevo siglo.",
        directorId: 4,
      }
    ]
  })

  await prisma.movie.update({
    where: {
      id: 1,
    },
    data: {
      actors: {
        connect: [
          { id: 2 }
        ]
      }
    }
  })

  await prisma.movie.update({
    where: {
      id: 2,
    },
    data: {
      actors: {
        connect: [
          { id: 3 }
        ]
      }
    }
  })

  await prisma.movie.update({
    where: {
      id: 3,
    },
    data: {
      actors: {
        connect: [
          { id: 1 }
        ]
      }
    }
  })

  await prisma.movie.update({
    where: {
      id: 4,
    },
    data: {
      actors: {
        connect: [
          { id: 4 },
          { id: 5 },
          { id: 6 }
        ]
      }
    }
  })

  await prisma.movie.update({
    where: {
      id: 5,
    },
    data: {
      actors: {
        connect: [
          { id: 7 },
          { id: 8 }
        ]
      }
    }
  })
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })