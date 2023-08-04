import axios from 'axios'

const httpClient = axios.create({
  // const token =
  baseURL: process.env.VUE_APP_BASE_URL,
  timeout: 1000, // indicates, 1000ms ie. 1 second
  headers: {
    'Content-Type': 'application/json'
    // anything you want to add to the headers
  }
  // FONCTION POUR AJOUTER HEADER S'IL Y EN A UN
  //const addAuthorizationHeader = (params:string) => {
  //   headers += `Authorization: Bearer ${token}`
  // }
})

export default httpClient
