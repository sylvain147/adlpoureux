const mysql = require('promise-mysql');
const slugify = require('slug');
require('dotenv').config();

let connection;
let params = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
};
const getConnection = async () => {
    if (connection) {
        return connection
    }

    connection = await mysql.createConnection(params);

    return connection
};

getProduct = async (req,res) => {
    isNaN(req.params.id) ? await getProductBySlug(req,res): await getProductById(req,res)  ;

};
getProductById = async (req,res) => {
    const connection = await getConnection();
    connection.query('SELECT * from product where product_id = ?', [req.params.id], function (error, results) {
        res.send(results);
    });
};

getProductBySlug = async (req,res) => {
    const connection = await getConnection();
    connection.query('SELECT *, url from product  LEFT JOIN picture_product on product.product_id = picture_product.product_id where slug = ?', [req.params.id], function (error, results) {
        console.log(error)
        console.log(results)
        res.send(results);
    });
};
getProducts = async (req, res) => {
    const connection = await getConnection();
    await connection.query('SELECT product_id,title, user.username, description, price, product.created_at from product JOIN user ON product.user_id = user.user_id', function (error, results) {
        res.send(results);
    });
};
createProduct = async (req,res) => {
    const connection = await getConnection();
    let body = req.body
    let description = body.description;
    let price = body.price;
    let title = body.title;
    let userId = body.userId;
    let slug = body.slug;
    console.log(title)
    if( !title || !userId || !slug || !price) {
        res.sendStatus(400);
        return;
    }
    delete body.title;
    delete body.userId;
    delete body.slug;
    let user = await connection.query("SELECT * from user where user_id = ?", [userId]);
    if (user.length === 0){
        res.sendStatus(404);
        return;
    }
    connection.query("INSERT INTO product set ?", {title: title,slug:slug, description : description, price : price, user_id : userId, created_at : new Date()},function (error, results) {
        console.log(error)
    });
    res.sendStatus(200)

};
createSlug = async (req,res) => {
    let i = 0;
    const connection = await getConnection();
    let originalSlug=  slugify(req.query.title);
    let slug = originalSlug;
    let result = await connection.query('SELECT * from article where slug = ?',[slug]);
    while (result.length > 0){
        i++;
        slug = originalSlug+'-'+i;
        result = await connection.query('SELECT * from article where slug = ?',[slug])
    }
    res.send(slug);
};

module.exports = {
    getProduct: async (req,res) => {
        await getProduct(req, res);
    },
    getProducts: async (req, res) => {
        await getProducts(req, res);
    },
    createProduct : async (req,res) => {
        await createProduct(req,res)
    },
    createSlug : async (req,res) =>{
        await createSlug(req,res)
    },
};
