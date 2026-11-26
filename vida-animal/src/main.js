import './style.css'

document.querySelector('#app').innerHTML = `
  <main class="status-card">
    <p class="eyebrow">Vida Animal</p>
    <h1>Status da API</h1>
    <p id="api-status" class="status" role="status" aria-live="polite">
      <span class="status-indicator" aria-hidden="true"></span>
      Verificando conexão...
    </p>
  </main>
`

const statusElement = document.querySelector('#api-status')

try {
  const response = await fetch('/api/health')
  if (!response.ok) {
    throw new Error(`Resposta HTTP ${response.status}`)
  }

  const health = await response.json()
  if (health.status !== 'ok') {
    throw new Error('Status de saúde inesperado')
  }

  statusElement.classList.add('is-online')
  statusElement.lastChild.textContent = 'API online'
} catch {
  statusElement.classList.add('is-offline')
  statusElement.lastChild.textContent = 'API offline'
}
