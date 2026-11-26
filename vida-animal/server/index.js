import { createServer } from 'node:http'

const port = Number(process.env.API_PORT) || 3001

const server = createServer((request, response) => {
  if (request.url === '/api/health' && request.method === 'GET') {
    response.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8' })
    response.end(JSON.stringify({ status: 'ok' }))
    return
  }

  response.writeHead(404, { 'Content-Type': 'application/json; charset=utf-8' })
  response.end(JSON.stringify({ error: 'Not found' }))
})

server.listen(port, () => {
  console.log(`API disponível em http://localhost:${port}`)
})
