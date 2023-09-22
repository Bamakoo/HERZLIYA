// import type { Books } from '@/libs/interfaces/books'
import httpClient from '../httpClient'
import type { Likes } from '@/libs/interfaces/likes'

export const useFetchLikes = () => {
  const list = async () => {
    const { data } = await httpClient.get<Likes[]>('/likes')
    return data
  }

  const retrieve = async (id: Likes['bookID']) => {
    const { data } = await httpClient.get<Likes>(`/likes/${id}`)
    return data
  }

  const create = async (id: Likes['bookID']) => {
    const { data } = await httpClient.post<Likes>(`/likes/${id}`, id)
    return data
  }

  const del = async (id: Likes['bookID']) => {
    const { data } = await httpClient.delete<Likes>(`/likes/${id}`)
    return data
  }

  return { list, retrieve, create, del }
}
