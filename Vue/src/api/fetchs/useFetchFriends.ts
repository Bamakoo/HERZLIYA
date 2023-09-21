import httpClient from '../httpClient'
import type { Friends } from '@/libs/interfaces/users'

export const useFetchFriends = () => {
  const list = async () => {
    const { data } = await httpClient.get<Friends['friendsId']>('/friends')
    return data
  }

  const retrieve = async (id: Friends['friendsId']) => {
    const { data } = await httpClient.get<Friends>(`/friends/${id}`)
    return data
  }

  const create = async (datas: Omit<Friends, 'userId'>) => {
    const { data } = await httpClient.post<Friends>('/friends', datas)
    return data
  }

  const del = async (id: Friends['userId']) => {
    const { data } = await httpClient.delete<Friends>(`/friends/${id}`)
    return data
  }

  return { list, retrieve, create, del }
}
