export default function StatusPage() {
  return (
    <main style={{ fontFamily: "system-ui, sans-serif", padding: "2rem" }}>
      <h1>Rimba API</h1>
      <p>Backend untuk Platform Digital SKU/SKK Pramuka. Lihat README.md.</p>
      <ul>
        <li>
          <code>GET /api/health</code>
        </li>
        <li>
          <code>POST /api/auth/login</code>
        </li>
        <li>
          <code>POST /api/auth/register</code>
        </li>
        <li>
          <code>GET /api/auth/me</code>
        </li>
        <li>
          <code>POST /api/sync/push</code>
        </li>
        <li>
          <code>GET /api/sync/pull?since=</code>
        </li>
        <li>
          <code>GET /api/materi/bundle</code>
        </li>
        <li>
          <code>GET /api/anggota</code> / <code>POST /api/anggota</code>
        </li>
      </ul>
    </main>
  );
}
