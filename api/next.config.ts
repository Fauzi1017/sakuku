import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Self-hosted on the VPS behind PM2 + Nginx (see ../deploy/vps_setup.sh)
  // rather than on Vercel — standalone output keeps the deployed footprint
  // to just the files `next start` actually needs.
  output: "standalone",
};

export default nextConfig;
