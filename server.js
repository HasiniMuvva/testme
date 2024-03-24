import express from 'express';
import { connection } from "./database.js";
import { implementHealthCheck } from "./healthzimplementation.js";
import { implementRestAPI } from './restapi.js';

const app = express();
const PORT = 3000;
app.use(express.json());
connection();
implementHealthCheck(app);
implementRestAPI(app);

app.use((req,res) => {
    res.status(404).end();
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
