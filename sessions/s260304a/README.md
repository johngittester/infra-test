# Contmontx Infrastructure — Deployment Configs

Internal deployment configurations for `contmontx.com` production environment.

## Stack

| Component | Technology | Host |
|-----------|-----------|------|
| Web App | Django 4.2 / Gunicorn | crm.contmontx.com |
| Database | PostgreSQL 16 | db.contmontx.com |
| Cache | Redis 7 | cache.contmontx.com |
| CDN | Cloudflare | contmontx.com |
| Container | Docker / K8s | 89.167.19.188 |
| Registry | AWS ECR | registry.contmontx.com |

## Directory Layout

```
sessions/s260304a/
├── .env                      # environment secrets
├── app/config.ini            # application config
├── backups/cmx_crm_prod.sql  # latest DB dump
├── credentials/
│   ├── aws_accessKeys.csv
│   ├── aws_credentials
│   ├── id_rsa
│   └── id_rsa.pub
├── deploy/
│   ├── docker-compose.yml
│   └── k8s-secrets.yaml
└── scripts/
    └── deploy.sh
```

> **Note**: Credentials in this repository are rotated after each deployment cycle.
> Commit hash: `4d5e13d9037e`
