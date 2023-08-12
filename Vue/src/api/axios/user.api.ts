import { ref } from 'vue'
import httpClient from './httpClient'
import type { Users } from '@/libs/interfaces/users'

// export const useFetchAccounts = async (id?: Users['id']) => {
//   const baseURL = '/users'
//   const list = httpClient.get<Users[]>(baseURL)
//   const getUser = httpClient.get<Users>(`${baseURL}/${id}`)
//   const update = httpClient.patch<Partial<Users>>(`${baseURL}/${id}`)
//   const del = httpClient.delete<Users>(`${baseURL}/${id}`)
//   return { list, getUser, update, del }
// }

export const useFetchAccounts = async () => {
  const baseURL = '/api/users'
  // const accountStore = useAccountStore()

  const token = ref('') // doit avoir le token du compte de la session
  // token.value = (await accountStore.fetchAccount()).account.token
  const list = async () => httpClient.get<Users[]>(baseURL)

  const retrieve = async (id: Users['id']) => httpClient.get<Users>(`${baseURL}/${id}`)

  const update = async (
    id: Users['id'],
    data: Omit<Users, 'id' | 'confirmPassword' | 'createdAt' | 'updatedAt' | 'deletedAt'>
  ) => {
    const user = httpClient.patch<Partial<Users>>(`${baseURL}/${id}`, data, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
    return user
  }

  const create = async (
    data: Omit<Users, 'id' | 'confirmPassword' | 'createdAt' | 'updatedAt' | 'deletedAt'>
  ) => {
    const user = httpClient.post(baseURL, data, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
    return user
  }

  const del = async (id: Users['id']) => {
    httpClient.delete<Users>(`${baseURL}/${id}`, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
  }

  return { list, retrieve, update, del, create }
}
