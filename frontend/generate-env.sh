#!/bin/sh

# Create assets directory if it doesn't exist
mkdir -p /usr/share/nginx/html/assets

# Generate env.js from environment variables
cat > /usr/share/nginx/html/assets/env.js << EOF
window.env = {
  apiUrl: "${API_URL:-/api/tutorials}"
};
EOF

echo "Generated env.js with API_URL=${API_URL:-/api/tutorials}"