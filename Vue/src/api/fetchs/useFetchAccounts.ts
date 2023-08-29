import httpClient from '../httpClient'
import type { Users } from '@/libs/interfaces/users'

export const useFetchAccounts = () => {
  const list = async () => {
    const { data } = await httpClient.get<Users[]>('/users', {})
    return data
  }

  const retrieve = async (id: Users['id']) => {
    const { data } = await httpClient.get<Users>(`/users/${id}`)
    return data
  }

  const create = async (
    datas: Omit<
      Users,
      'id' | 'updatedAt' | 'books' | 'cart' | 'sales' | 'friends' | 'token' | 'purchases'
    >
  ) => {
    const { data } = await httpClient.post<Users>('/users', { data: datas })
    return data
  }

  const update = async (id: Users['id'], datas: Omit<Users, 'id'>) => {
    const { data } = await httpClient.patch<Partial<Users>>(`/users/${id}`, { data: datas })
    return data
  }

  const del = async (id: Users['id']) => {
    const { data } = await httpClient.delete<Users>(`/users/${id}`)
    return data
  }

  return { list, retrieve, create, update, del }
}
