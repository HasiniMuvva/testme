import { Sequelize } from "sequelize";
import { userModel } from "./model/user.js";
import dotenv from 'dotenv';
dotenv.config(); 

const sequelize = new Sequelize({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    dialect: 'mysql',
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

let User = null;
export const connection = async () => {
    try {
        await sequelize.authenticate();
        console.log('Connection has been established successfully.');
        User = userModel(sequelize);
        await sequelize.sync();
        console.log('Table created successfully');
    } catch (error) {
        console.error('Unable to connect to the database:', error);
    }
};
export { sequelize, User };

