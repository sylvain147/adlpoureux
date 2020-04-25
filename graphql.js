const {ApolloServer, gql} = require('apollo-server');
const mysql = require('promise-mysql');
let params = {
    host: `localhost`,
    user: `sylvain`,
    password: `2459`,
    database: `adl`,
};
// A schema is a collection of type definitions (hence "typeDefs")
// that together define the "shape" of queries that are executed against
// your data.
const typeDefs = gql`
type Mutation {
  createProduct(productInput: ProductInput!): Product!
  createUser(userInput: UserInput!): User!
}
type Query {
  getProducts : [Product]!
  getProduct(id: Int!): Product!
  getUser(id: Int!): User!
  getUsers : [User]!
}
type Level  {
  level_id : Int!
  name : String!
  level : Int!
}
type User {
  user_id : Int!
  avatar : String!
  firstname : String
  lastname : String
  username : String!
  birthday : String
  email : String!
  created_at : String!
  deleted_at : String
}

type Product {
  product_id : Int
  title : String!
  description : String
  price : Float!
  user_id : Int!
  user : User!
  slug : String!
  created_at : String!
  deleted_at : String
}

type Picture_product {
  picture_product_id : Int!
  product_id : Int!
  product : Product
  name : String
  url : String!
  created_at : String!
  deleted_at : String
  
}

type Category {
  category_id : Int!
  title : String!
  description : String!
  slug : String!
  created_at : String!
  deleted_at : String
}

type Tag {
  tag_id : Int!
  owner_id : Int!
  title : String!
  slug : String!
  created_at : String!
  deleted_at : String
}

type Order {
  order_id : Int!
  user_id : Int!
  user : User!
}

type Order_line {
  order_line_id : Int!
  order_id : Int!
  order : Order
  product_id : Int!
  product : Product
  quantity : Int!
  price : Int!
  total_price : Int!
}
input ProductInput {
  title : String
  description : String
  price : Float!
  user_id : Int!
  slug : String!
}
input UserInput {
  firstname : String
  lastname : String
  username : String!
  birthday : String
  email : String!
  password : String!
}
`
const resolvers = {
    Query: {
        async getProduct(_, {id}, context) {
            const product = await context.connection.query(`SELECT * from product where product_id = ?`, [id])
            return product[0]
        },
        async getProducts(_, {}, context) {
            const products = await context.connection.query(`SELECT * from product`)
            return products;
        },
        async getUser(_, {id}, context) {
            const user = await context.connection.query(`SELECT * from user where user_id = ?`, [id])
            return user;
        },
        async getUsers(_,{},context) {
            const users = await context.connection.query(`SELECT * from user`, [id])
            return users;
        }
    },
    Mutation: {
        async createProduct(_, {productInput}, context) {
            const {insertId} = await context.connection.query('INSERT INTO product set ?', {
                title : productInput.title,
                description :  productInput.description,
                price :  productInput.price,
                user_id : productInput.user_id,
                slug :  productInput.slug,
                created_at :  new Date(),
            })
            const product = await context.connection.query(`SELECT * from product where product_id = ?`, insertId)
            return product[0]
        },
        async createUser(_, {userInput}, context) {
            const {insertId} = await context.connection.query('INSERT INTO user set ?', {
                firstname: userInput.firstname,
                lastname: userInput.lastname,
                username: userInput.username,
                password: userInput.password,
                email: userInput.email,
                created_at: new Date()
            })
            const user = await context.connection.query(`SELECT * from user where user_id = ?`, [insertId])

            return user[0]
        }
    },
    Product: {
        async user(parent, {}, context) {
            const user = await context.connection.query(`SELECT * from user where user_id = ?`, [parent.user_id])
            return user[0]
        }
    }
}
let connection
const getConnection = async () => {
    if (connection) {
        return connection
    }

    connection = await mysql.createConnection(params);

    return connection
};
const server = new ApolloServer({
    typeDefs,
    resolvers,
    async context() {
        return {
            connection: await getConnection()
        }
    }
});

// The `listen` method launches a web server.
server.listen().then(({url}) => {
    console.log(`🚀  Server ready at ${url}`);
})