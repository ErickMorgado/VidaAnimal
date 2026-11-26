# VidaAnimal
Repositório da ONG Vida Animal, criado para promover a proteção e o bem-estar dos animais, incentivando a adoção responsável, vacinação, castração e conscientização sobre o abandono e os maus-tratos.

## Como rodar o projeto

Requisitos: Node.js e npm instalados.

1. Abra um terminal na pasta da aplicação:

   ```sh
   cd vida-animal
   ```

2. Instale as dependências:

   ```sh
   npm install
   ```

3. Inicie a API em um terminal:

   ```sh
   npm run api
   ```

   A API ficará disponível em `http://localhost:3001`. O endpoint `GET /api/health` retorna `{"status":"ok"}`.

4. Em outro terminal, na pasta `vida-animal`, inicie o frontend:

   ```sh
   npm run dev
   ```

5. Abra no navegador o endereço informado pelo Vite (normalmente `http://localhost:5173`). A página inicial mostra se a API está online.

O Vite encaminha as requisições `/api` para a API local na porta `3001`. Para gerar a versão de produção, execute `npm run build`.
