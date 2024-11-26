import pkg from 'pg';
import dotenv from "dotenv"

const { Pool } = pkg;
dotenv.config();

// Pool erstellen

const pool = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT
})


export const query = async (text, params) => {
    try {
        const result = await pool.query(text, params);
        return result;
    } catch (err) {
        console.error('Database query error:', err);
        throw err;
    }
};


export default pool