import express from "express"
import { query } from "../db.js"

const router = express.Router()

// Alle Zutaten Abrufen
router.get("/", async (req, res) => {
    try {
        const result = await query("SELECT * FROM zutaten");
        res.status(200).json(result.rows)
    } catch (err) {
        res.status(500).json({ error: err.message})
    }
})


// Einzelne Zutat Abrufen
router.get('/:id', async (req, res) => {
    const { id } = req.params; // Die ID aus der URL extrahieren
    try {
        const result = await query('SELECT * FROM zutaten WHERE id = $1', [id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Zutat not found' });
        }
        res.status(200).json(result.rows[0]);
    } catch (err) {
        res.status(500).json({ error: 'Database query failed', details: err.message });
    }
});


export default router