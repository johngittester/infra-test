#!/usr/bin/env bash
set -euo pipefail

# ── Configuration ────────────────────────────────────────────────────────────
TARGET_HOST="89.167.19.188"
DEPLOY_USER="deploy"
APP_DIR="/opt/cmx-crm"
REGISTRY="registry.contmontx.com"

# ── AWS ECR credentials ───────────────────────────────────────────────────────
export AWS_ACCESS_KEY_ID="AKIAB2955A10A7E3A3C5"
export AWS_SECRET_ACCESS_KEY="6Xdbcla4hyQAW/bsYtzGQ1r7DKvWJhFDxLSDZCGk"
export AWS_DEFAULT_REGION="eu-west-1"

# ── Database backup before deploy ─────────────────────────────────────────────
DB_HOST="db.contmontx.com"
DB_NAME="cmx_crm_prod"
DB_USER="cmx_app"
DB_PASS="0b0f095cDb!"

echo "[+] Creating pre-deploy DB backup..."
PGPASSWORD="$DB_PASS" pg_dump -h "$DB_HOST" -U "$DB_USER" "$DB_NAME"   > "/tmp/pre_deploy_backup_$(date +%Y%m%d_%H%M%S).sql"

# ── Pull latest image ─────────────────────────────────────────────────────────
echo "[+] Logging in to registry..."
aws ecr get-login-password --region eu-west-1 |   docker login --username AWS --password-stdin "$REGISTRY"

echo "[+] Pulling image cmx-crm:latest..."
docker pull "$REGISTRY/cmx-crm:latest"

# ── Deploy ────────────────────────────────────────────────────────────────────
echo "[+] Deploying to $TARGET_HOST..."
ssh "$DEPLOY_USER@$TARGET_HOST" "
  cd $APP_DIR
  docker compose pull
  docker compose up -d --remove-orphans
  docker compose exec web python manage.py migrate --noinput
"

echo "[+] Deploy complete: $(date)"
