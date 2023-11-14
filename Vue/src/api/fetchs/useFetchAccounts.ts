import httpClient from '../httpClient'
import type { Users } from '@/libs/interfaces/users'

export const useFetchAccounts = () => {
  const token = localStorage.getItem('token')

  const list = async () => {
    const { data } = await httpClient.get<Users[]>('/users')
    return data
  }

  const retrieve = async (id: Users['id']) => {
    const { data } = await httpClient.get<Users>(`/users/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return data
  }

  const infos = async () => {
    const { data } = await httpClient.get<Users>('/my')
    return data
  }

  const purchases = async () => {
    const { data } = await httpClient.get('users/purchases')
    return data
  }

  const likes = async () => {
    const { data } = await httpClient.get('users/likes')
    return data
  }

  const create = async (
    datas: Omit<
      Users,
      'id' | 'updatedAt' | 'books' | 'cart' | 'sales' | 'friends' | 'token' | 'purchases'
    >
  ) => {
    const { data } = await httpClient.post<Users>('/users', datas)
    return data
  }

  const update = async (id: Users['id'], datas: Omit<Users, 'id'>) => {
    const { data } = await httpClient.patch<Partial<Users>>(`/users/${id}`, datas, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return data
  }

  const del = async (id: Users['id']) => {
    const { data } = await httpClient.delete<Users>(`/users/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return data
  }

  return { list, retrieve, profile: { infos, purchases, likes }, create, update, del }
}
