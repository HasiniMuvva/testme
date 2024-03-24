import { sequelize } from './database.js';
export const implementHealthCheck = (app) => {
    app.get('/healthz', async (req, res) => {
        try {
            await sequelize.authenticate();
            res.setHeader('Cache-Control', 'no-cache');
            res.status(200).send('');
        } catch (error) {
            console.error('Unable to connect to the database:', error);
            res.setHeader('Cache-Control', 'no-cache');
            res.status(503).end();
        }
    });
};
