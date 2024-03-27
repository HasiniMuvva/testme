import { Sequelize } from "sequelize";
import bcrypt from 'bcrypt';

export const userModel = (sequelize) => {
    const { DataTypes } = Sequelize;

    const User = sequelize.define("user", {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true,
            readOnly: true
        },
        username: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
            validate: {
                isEmail: true
            }
        },
        password: {
            type: DataTypes.STRING,
            allowNull: false,
            writeOnly: true
        },
        firstname: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        lastname: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        account_created: {
            type: DataTypes.DATE,
            allowNull: false,
            defaultValue: Sequelize.NOW,
            readOnly: true
        },
        account_updated: {
            type: DataTypes.DATE,
            allowNull: false,
            defaultValue: Sequelize.NOW,
            readOnly: true
        },
    }, {
        defaultScope: {
            attributes: {  }, 
        },
    });

    User.prototype.validPassword = async function (password) {
        return await bcrypt.compare(password, this.password);
    };

    return User;
};