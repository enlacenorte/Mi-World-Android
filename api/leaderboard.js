// Vercel Serverless Function: /api/leaderboard.js
// Global Top 10 Cloud Database API for GEO ORBIT: World Odyssey 3D
// Author: Alejandro (enlacenorte@gmail.com)

let globalTop10 = [
  { name: "ALEX", score: 3500, date: "2026-08-29" },
  { name: "MARA", score: 2800, date: "2026-08-29" },
  { name: "CYBR", score: 2200, date: "2026-08-29" },
  { name: "NEON", score: 1800, date: "2026-08-29" },
  { name: "NOVA", score: 1450, date: "2026-08-29" },
  { name: "ZETA", score: 1100, date: "2026-08-29" },
  { name: "ORBT", score: 850, date: "2026-08-29" },
  { name: "AURA", score: 650, date: "2026-08-29" },
  { name: "PULZ", score: 480, date: "2026-08-29" },
  { name: "ECHO", score: 300, date: "2026-08-29" }
];

export default async function handler(req, res) {
  // CORS Headers
  res.setHeader("Access-Control-Allow-Credentials", "true");
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET,OPTIONS,PATCH,DELETE,POST,PUT");
  res.setHeader(
    "Access-Control-Allow-Headers",
    "X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version"
  );

  if (req.method === "OPTIONS") {
    res.status(200).end();
    return;
  }

  // GET: Obtener Top 10 global
  if (req.method === "GET") {
    globalTop10.sort((a, b) => b.score - a.score);
    return res.status(200).json({
      status: "success",
      source: "vercel_cloud_db",
      timestamp: new Date().toISOString(),
      leaderboard: globalTop10.slice(0, 10)
    });
  }

  // POST: Enviar y registrar puntaje de usuario
  if (req.method === "POST") {
    try {
      const body = typeof req.body === "string" ? JSON.parse(req.body) : (req.body || {});
      const rawName = (body.name || "JUG1").toString().trim().toUpperCase().slice(0, 4);
      const rawScore = parseInt(body.score, 10);

      if (isNaN(rawScore) || rawScore <= 0) {
        return res.status(400).json({ error: "Invalid score value" });
      }

      const newEntry = {
        name: rawName || "JUG1",
        score: rawScore,
        date: new Date().toISOString().split("T")[0]
      };

      globalTop10.push(newEntry);
      globalTop10.sort((a, b) => b.score - a.score);
      globalTop10 = globalTop10.slice(0, 10);

      return res.status(200).json({
        status: "success",
        message: "Record verified and saved in cloud database",
        rank: globalTop10.findIndex(e => e === newEntry) + 1,
        leaderboard: globalTop10
      });
    } catch (err) {
      return res.status(500).json({ error: "Failed to process score submission", details: err.message });
    }
  }

  return res.status(405).json({ error: "Method not allowed" });
}
