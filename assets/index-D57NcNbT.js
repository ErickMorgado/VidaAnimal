(function(){let e=document.createElement(`link`).relList;if(e&&e.supports&&e.supports(`modulepreload`))return;for(let e of document.querySelectorAll(`link[rel="modulepreload"]`))n(e);new MutationObserver(e=>{for(let t of e)if(t.type===`childList`)for(let e of t.addedNodes)e.tagName===`LINK`&&e.rel===`modulepreload`&&n(e)}).observe(document,{childList:!0,subtree:!0});function t(e){let t={};return e.integrity&&(t.integrity=e.integrity),e.referrerPolicy&&(t.referrerPolicy=e.referrerPolicy),t.credentials=e.crossOrigin===`use-credentials`?`include`:e.crossOrigin===`anonymous`?`omit`:`same-origin`,t}function n(e){if(e.ep)return;e.ep=!0;let n=t(e);fetch(e.href,n)}})(),document.querySelector(`#app`).innerHTML=`
  <main class="status-card">
    <p class="eyebrow">Vida Animal</p>
    <h1>Status da API</h1>
    <p id="api-status" class="status" role="status" aria-live="polite">
      <span class="status-indicator" aria-hidden="true"></span>
      Verificando conexão...
    </p>
  </main>
`;var e=document.querySelector(`#api-status`);try{let t=await fetch(`/api/health`);if(!t.ok)throw Error(`Resposta HTTP ${t.status}`);if((await t.json()).status!==`ok`)throw Error(`Status de saúde inesperado`);e.classList.add(`is-online`),e.lastChild.textContent=`API online`}catch{e.classList.add(`is-offline`),e.lastChild.textContent=`API offline`}