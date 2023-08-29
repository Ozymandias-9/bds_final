const bcrypt = require('bcrypt');

module.exports = {
    hash: (password) => {
        return bcrypt.hashSync(password, 12);
    },
    dehash: (password, hash) => {
        return bcrypt.compareSync(password, hash)
    }
}