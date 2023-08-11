// api/api.ts
import axios from 'axios'

const api = axios.create({
  baseURL: 'https://your-api-url.com'
})

// Ajoutez le Bearer token à chaque requête
api.interceptors.request.use((config) => {
  const token = ''
  config.headers.Authorization = `Bearer ${token}`
  return config
})

export default api
