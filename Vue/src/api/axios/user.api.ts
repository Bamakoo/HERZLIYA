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

export const useFetchAccounts = () => {
  const baseURL = '/api/users'
  // const accountStore = useAccountStore()

  const token = ref('') // doit avoir le token du compte de la session
  // token.value = (await accountStore.fetchAccount()).account.token
  const list = async () => {
    const { data } = await httpClient.get<Users[]>(baseURL)
    return data
  }

  const retrieve = async (id: Users['id']) => {
    const { data } = await httpClient.get<Users>(`${baseURL}/${id}`)
    return data
  }

  const update = async (
    id: Users['id'],
    datas: Omit<Users, 'id' | 'confirmPassword' | 'createdAt' | 'updatedAt' | 'deletedAt'>
  ) => {
    const { data } = await httpClient.patch<Partial<Users>>(`${baseURL}/${id}`, datas, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
    return data
  }

  //Omit<Users, 'id' | 'confirmPassword' | 'createdAt' | 'updatedAt' | 'deletedAt'>
  const create = async (datas: Users) => {
    const { data } = await httpClient.post<Users>(
      baseURL,
      { datas: (datas.createdAt = Date.now()) },
      {
        headers: { Authorization: `Bearer ${token.value}` }
      }
    )
    return data
  }

  const del = async (id: Users['id']) => {
    const { data } = await httpClient.delete<Users>(`${baseURL}/${id}`, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
    return data
  }

  return { list, retrieve, update, del, create }
}
