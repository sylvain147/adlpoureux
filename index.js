const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const multer = require("multer");
let upload = multer();
let jwt = require('jsonwebtoken');
let cors = require('cors');


const product = require('./src/product');
const user = require('./src/user');
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
    extended: true
}));
/** Articles **/
//GET functions
app.get('/api/products', product.getProducts);
app.get('/api/product', product.getProduct);
app.get('/api/product/:id', product.getProduct);
app.get('/api/slug', product.createSlug);

//POST functions
app.post('/api/product',upload.none(), product.createProduct);
/** fin Articles **/

/** Users **/
//GET functions
const authorize = (req, res, next) => {
    console.log('ok')
    if (req.headers['authorization'] !== 'null') {
        jwt.verify(req.headers['authorization'], 'untrucsecret', function (err, decoded) {
            if (err) next();
            req.user = decoded
        })
    }
    next()
};
app.get('/api/users', user.getUsers);
app.get('/api/user/:id', user.getUser);

//POST functions
app.post('/api/user', user.createUser);
app.post('/api/login', user.login);
app.post('/api/authed', authorize, user.auth);
app.post('/api/reloaduser',authorize,user.reloadUser);

//PUT functions
app.put('/api/user/:id',upload.none(), user.updateUser);
/** FIN users **/
app.post('/api/image', user.updateAvatar);
console.log(process.env.APP_PORT)
app.listen(process.env.APP_PORT);
