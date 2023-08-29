const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    try{
        const token = jwt.decode(req.headers.auth, process.env.JWT_KEY);
        
        if (token.role == 'admin') {
            next();
        }
        else {
            return res.json({ code: 400, message: 'Permisos insuficientes' });
        }
    }catch(error){
        return res.json({ code: 400, message: 'Permisos insuficientes' });
    }
}