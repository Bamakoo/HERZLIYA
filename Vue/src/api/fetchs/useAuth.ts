import httpClient from '../httpClient'
import type { Users } from '@/libs/interfaces/users'

export const useFetchAccounts = () => {
  // const list = async () => {
  //   const { data } = await httpClient.get<Users[]>('/auth')
  //   return data
  // }

  const retrieve = async (id: Users['id']) => {
    const { data } = await httpClient.get<Users>(`/auth/${id}`)
    return data
  }

  const create = async (
    datas: Omit<
      Users,
      'id' | 'updatedAt' | 'books' | 'cart' | 'sales' | 'friends' | 'token' | 'purchases'
    >
  ) => {
    const { data } = await httpClient.post<Users>('/login', datas)
    return data
  }

  return { retrieve, create }
}
