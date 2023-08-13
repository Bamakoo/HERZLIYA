// import accountStore from '@/libs/composables/accounts'
// import type { Users } from '@/libs/interfaces/users'
// import axios from 'axios'
//fetch du compte
//route /users
//format des données JSON
//authentification

//isAuthenticated
//account
//metadata
//sales
//purchases

// export const useFetchAccount = () => {
//   const token = accountStore.token
//   const id = accountStore.id
//   const account = async () => {
//     const res = await axios.get<Users>(`/users/${id}`)
//     return res
//   }

//   const books = async () => {
//     const { data } = await axios.get<Users['books']>('/users')
//     return data
//   }

//   const sales = async () => {
//     const { data } = await axios.get<Users['sales']>(`/users/${token}/purchases`)
//     return data
//   }
//   const orders = async () => {
//     const { data } = await axios.get<Users['orders']>(`/users/${token}/orders`)
//     return data
//   }

//   return { account, books, sales, orders }
// }
