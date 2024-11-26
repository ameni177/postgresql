import express from "express"
import { query } from "../db.js"

const router = express.Router()

// Alle Pizzen Abrufen
router.get("/", async (req, res) => {
    try {
        const result = await query("SELECT * FROM bestellungen");
        res.status(200).json(result.rows)
    } catch (err) {
        res.status(500).json({ error: err.message})
    }
})
router.post("/", async (req, res) => {
    try {
        // Direkt auf die Daten aus req.body zugreifen
        const { kunden_id, lieferadresse, bestellung, gesamtpreis, status } = req.body;

        // SQL-Insert mit Platzhaltern
        const result = await query(
            "INSERT INTO bestellungen (kunden_id, lieferadresse, bestellung, gesamtpreis, status) VALUES ($1, $2, $3, $4, $5) RETURNING *", 
            [kunden_id, lieferadresse, bestellung, gesamtpreis, status]
        );

        // Antwort mit der eingefügten Bestellung (z.B. ID und andere Details)
        res.status(200).json({ message: "Bestellung erfolgreich erstellt", bestellung: result.rows[0] });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: err.message });
    }
})

export default router