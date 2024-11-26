import express from "express"
import { query } from "../db.js"

const router = express.Router()

// Alle Pizzen Abrufen
router.get("/", async (req, res) => {
    try {
        const result = await query("SELECT * FROM karte");
        res.status(200).json(result.rows)
    } catch (err) {
        res.status(500).json({ error: err.message})
    }
})
router.get('/:id', async (req, res) => {
    const { id } = req.params; // Die ID aus der URL extrahieren
    try {
        const result = await query('SELECT * FROM karte WHERE id = $1', [id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Pizza  not found' });
        }
        res.status(200).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: 'Database query failed', details: err.message });
    }
});
export default router