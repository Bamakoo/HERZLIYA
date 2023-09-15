import axios from 'axios'

const httpClient = axios.create({
  baseURL: import.meta.env.VITE_BASE_URL,
  timeout: 1000,
  headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': import.meta.env.VITE_BASE_URL,
    Accept: 'application/json'
  }
})

export default httpClient
