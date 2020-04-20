const { ApolloServer, gql } = require('apollo-server');
const mysql = require('promise-mysql');
let params = {
    host: `localhost`,
    user: `sylvain`,
    password: `Zg4nwp6jim`,
    database: `adl`,
};
console.log(params)
// A schema is a collection of type definitions (hence "typeDefs")
// that together define the "shape" of queries that are executed against
// your data.
const typeDefs = gql`
type Mutation {
  createProduct(productInput: ProductInput!): Product!
  createUser(userInput: UserInput!): User!
}

type Query {
  product(id: Int!): Product!
  user(id: Int!): User!
}
type User {
  user_id : Int!
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
    async product(_,{id},context) {
      const product = await context.connection.query(`SELECT * from product where product_id = ?`, [id]) 
      return product[0]
    }
  },
  Mutation: {
    async createProduct(){

    },
    async createUser(_,{userInput},context){
      const {insertId} = await context.connection.query('INSERT INTO user set ?', {
        firstname : userInput.firstname,
        lastname : userInput.lastname,
        username : userInput.username, 
        password : userInput.password, 
        email : userInput.email,
        created_at: new Date()
      })
      const user = await context.connection.query(`SELECT * from user where user_id = ?`, [insertId])
      console.log(user)
      return user[0]
    }
  },
  Product:{
    async user(parent,{},context) {
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
      connection : await getConnection()
    }
  } 
});

// The `listen` method launches a web server.
server.listen().then(({ url }) => {
  console.log(`🚀  Server ready at ${url}`);
})