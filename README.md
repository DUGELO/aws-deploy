# 🔐 Gerador de Senhas Seguras

Um gerador de senhas moderno, seguro e totalmente client-side, desenvolvido com foco em segurança e usabilidade.

[![Deploy Status](https://img.shields.io/badge/deploy-live-brightgreen)](https://d2d7n2ooug896c.cloudfront.net/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![HTML5](https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=white)](https://developer.mozilla.org/docs/Web/HTML)
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?logo=css3&logoColor=white)](https://developer.mozilla.org/docs/Web/CSS)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)](https://developer.mozilla.org/docs/Web/JavaScript)
[![AWS S3](https://img.shields.io/badge/AWS%20S3-569A31?logo=amazon-s3&logoColor=white)](https://aws.amazon.com/s3/)
[![CloudFront](https://img.shields.io/badge/CloudFront-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/cloudfront/)

## 🚀 Demo

**[Acesse o Gerador de Senhas](https://d2d7n2ooug896c.cloudfront.net/)**

## ✨ Características

- 🔒 **100% Seguro**: Todas as senhas são geradas localmente no navegador
- ⚡ **Ultra Rápido**: Geração instantânea de senhas
- 🎯 **Personalizável**: Configure comprimento (4-50 caracteres) e tipos de caracteres
- 📱 **Responsivo**: Funciona perfeitamente em todos os dispositivos
- 🌐 **Zero Dependências**: Vanilla JavaScript puro
- 🎨 **UI Moderna**: Interface limpa e intuitiva
- 🔄 **Cópia Rápida**: Um clique para copiar a senha

## 🛠️ Tecnologias

- **Frontend**: HTML5, CSS3, Vanilla JavaScript
- **Hospedagem**: Amazon S3 (Static Website Hosting)
- **CDN**: Amazon CloudFront
- **HTTPS**: Certificado SSL/TLS automático via CloudFront
- **Deploy**: AWS CLI

## 🏗️ Arquitetura de Deploy

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Desenvolvedor │───▶│   Amazon S3      │───▶│  CloudFront CDN │
│                 │    │  Static Website  │    │   + HTTPS       │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                                         │
                                                         ▼
                                                ┌─────────────────┐
                                                │  Usuários       │
                                                │  Globais        │
                                                └─────────────────┘
```

### Vantagens da Arquitetura

- **Performance**: CDN global com cache inteligente
- **Segurança**: HTTPS por padrão + CSP headers
- **Escalabilidade**: Suporte automático a qualquer volume de tráfego  
- **Custo**: Pay-per-use, sem custos fixos de servidor
- **Disponibilidade**: 99.9% de uptime garantido pela AWS

## 🚀 Deploy

### Pré-requisitos

- AWS CLI configurado
- Conta AWS ativa
- Node.js (opcional, para build scripts)

### Passo a Passo

1. **Criar Bucket S3**
```bash
aws s3 mb s3://seu-bucket-name
```

2. **Configurar Static Website Hosting**
```bash
aws s3 website s3://seu-bucket-name --index-document index.html
```

3. **Upload dos Arquivos**
```bash
aws s3 sync ./dist s3://seu-bucket-name --delete
```

4. **Criar CloudFront Distribution**
```bash
aws cloudfront create-distribution --distribution-config file://cloudfront-config.json
```

5. **Configurar DNS** (Opcional)
```bash
# Configurar Route 53 para domínio customizado
```

### Configuração do Bucket Policy

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::seu-bucket-name/*"
    }
  ]
}
```

## 📦 Estrutura do Projeto

```
gerador-senhas/
├── index.html          # Página principal
├── css/
│   ├── style.css      # Estilos principais
│   └── responsive.css # Media queries
├── js/
│   ├── generator.js   # Lógica de geração
│   └── ui.js         # Interações da UI
├── assets/
│   ├── icons/        # Ícones SVG
│   └── images/       # Imagens otimizadas
├── deploy/
│   ├── deploy.sh     # Script de deploy
│   └── cloudfront-config.json
└── README.md
```

## 🔧 Desenvolvimento Local

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/gerador-senhas.git

# Entre no diretório
cd gerador-senhas

# Inicie um servidor local (Python)
python -m http.server 8000

# Ou usando Node.js
npx http-server

# Acesse http://localhost:8000
```

## 🧪 Testes

```bash
# Execute os testes unitários
npm test

# Testes de segurança
npm run security-test

# Lighthouse audit
npm run audit
```

## 📊 Performance

- **First Contentful Paint**: < 1.5s
- **Largest Contentful Paint**: < 2.5s
- **Time to Interactive**: < 3.0s
- **Cumulative Layout Shift**: < 0.1
- **Lighthouse Score**: 98/100

## 🔐 Segurança

### Práticas Implementadas

- ✅ Geração client-side usando `crypto.getRandomValues()`
- ✅ Content Security Policy (CSP) headers
- ✅ HTTPS obrigatório via CloudFront
- ✅ No tracking ou analytics invasivos
- ✅ Sem armazenamento de senhas
- ✅ Subresource Integrity (SRI) para CDNs

### Auditoria de Segurança

```bash
# Verificar vulnerabilidades
npm audit

# Análise de segurança com Snyk
snyk test
```

## 🤝 Contribuindo

1. Fork o projeto
2. Crie sua feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Agradecimentos

- [Web Crypto API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Crypto_API) - Para geração segura de números aleatórios
- [AWS Free Tier](https://aws.amazon.com/free/) - Hospedagem gratuita
- [Shields.io](https://shields.io/) - Badges do README

## 📞 Contato

Seu Nome - [@seu_twitter](https://twitter.com/seu_twitter) - seu.email@gmail.com

Link do Projeto: [https://github.com/seu-usuario/gerador-senhas](https://github.com/seu-usuario/gerador-senhas)

---

⭐ Se este projeto te ajudou, considere dar uma estrela!

