#!/bin/bash

# Deploy CloudFront para gerador-de-senhas
echo "🚀 Configurando CloudFront para HTTPS..."

# 1. Criar distribuição CloudFront
cat > cloudfront-config.json << 'EOF'
{
    "CallerReference": "gerador-senhas-$(date +%s)",
    "Comment": "Gerador de Senhas - HTTPS",
    "DefaultRootObject": "index.html",
    "Origins": {
        "Quantity": 1,
        "Items": [
            {
                "Id": "S3-gerador-de-senhas",
                "DomainName": "gerador-de-senhas.s3-website-sa-east-1.amazonaws.com",
                "CustomOriginConfig": {
                    "HTTPPort": 80,
                    "HTTPSPort": 443,
                    "OriginProtocolPolicy": "http-only"
                }
            }
        ]
    },
    "DefaultCacheBehavior": {
        "TargetOriginId": "S3-gerador-de-senhas",
        "ViewerProtocolPolicy": "redirect-to-https",
        "TrustedSigners": {
            "Enabled": false,
            "Quantity": 0
        },
        "ForwardedValues": {
            "QueryString": false,
            "Cookies": {
                "Forward": "none"
            }
        },
        "MinTTL": 0,
        "DefaultTTL": 86400,
        "MaxTTL": 31536000,
        "Compress": true
    },
    "CustomErrorResponses": {
        "Quantity": 1,
        "Items": [
            {
                "ErrorCode": 404,
                "ResponsePagePath": "/index.html",
                "ResponseCode": "200",
                "ErrorCachingMinTTL": 300
            }
        ]
    },
    "Enabled": true,
    "PriceClass": "PriceClass_100"
}
EOF

# 2. Substituir CallerReference único
sed -i "s/gerador-senhas-\$(date +%s)/gerador-senhas-$(date +%s)/" cloudfront-config.json

# 3. Criar distribuição
echo "📡 Criando distribuição CloudFront..."
DISTRIBUTION_ID=$(aws cloudfront create-distribution \
    --distribution-config file://cloudfront-config.json \
    --query 'Distribution.Id' \
    --output text)

echo "✅ CloudFront criado!"
echo "🆔 Distribution ID: $DISTRIBUTION_ID"
echo "⏳ Aguardando deploy (5-15 minutos)..."

# 4. Aguardar deploy
aws cloudfront wait distribution-deployed --id $DISTRIBUTION_ID

# 5. Obter URL final
CLOUDFRONT_URL=$(aws cloudfront get-distribution \
    --id $DISTRIBUTION_ID \
    --query 'Distribution.DomainName' \
    --output text)

echo ""
echo "🎉 DEPLOY CONCLUÍDO!"
echo "🌐 URL HTTPS: https://$CLOUDFRONT_URL"
echo "📱 Use esta URL no Google Ads"
echo ""
echo "🔄 Para atualizações futuras, use:"
echo "aws s3 cp index.html s3://gerador-de-senhas/"
echo "aws cloudfront create-invalidation --distribution-id $DISTRIBUTION_ID --paths '/*'"

# Limpar arquivo temporário
rm cloudfront-config.json