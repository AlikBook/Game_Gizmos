export default async function handler(req, res) {
  const result = await fetch("https://api.github.com/repos/AlikBook/Game_Gizmos/actions/workflows/start_db.yml/dispatches", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${process.env.GITHUB_TOKEN}`,
      Accept: "application/vnd.github.v3+json",
    },
    body: JSON.stringify({ ref: "main" }),
  });

  res.status(200).json({ message: "Waking up database" });
}
