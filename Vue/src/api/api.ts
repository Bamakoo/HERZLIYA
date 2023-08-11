// api/api.ts
import axios from 'axios'
import { useAccountStore } from '@/stores/useAccountStore'
const fetchAccount = useAccountStore()

const api = axios.create({
  baseURL: import.meta.env.BASE_URL
})

// Ajoutez le Bearer token à chaque requête
api.interceptors.request.use((config) => {
  const token = fetchAccount.token
  config.headers.Authorization = `Bearer ${token}`
  return config
})

export default api
