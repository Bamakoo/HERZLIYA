import axios from 'axios'

const httpClient = axios.create({
  // const token =
  baseURL: import.meta.env.VITE_BASE_URL,
  timeout: 1000,
  headers: {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': import.meta.env.VITE_BASE_URL,
    Accept: 'application/json'
  }
  // FONCTION POUR AJOUTER HEADER S'IL Y EN A UN
  //const addAuthorizationHeader = (params:string) => {
  //   headers += `Authorization: Bearer ${token}`
  // }
})

export default httpClient
