### Imagem base utilizada para construção da imagem
FROM node:18.11.0@sha256:cefabaed21ef3343a020528dc508155dacd2d5f7ac2b18524b58ea41aa133290

### Diretório padrão de trabalho
WORKDIR /app

### Copiando package.json para instalar as bibliotecas necessárias.
COPY src/package*.json ./

### Instalando as bibliotecas do node
RUN npm install

### Copiando todo projeto para dentro da imagem.
COPY src/ .

### Expondo a porta da aplicação
EXPOSE 8080

### Principal processo da imagem quando estiver em execução.
CMD ["node", "server.js"]