// import type { Books } from '@/libs/interfaces/books'
import httpClient from '../httpClient'
import type { Likes } from '@/libs/interfaces/likes'

export const useFetchLikes = () => {
  const list = async () => {
    const { data } = await httpClient.get<Likes[]>('/likes')
    return data
  }

  const retrieve = async (id: Likes['bookID']) => {
    const token = localStorage.getItem('token')
    const { data } = await httpClient.get<Likes>(`/likes/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return data
  }

  const create = async (id: Likes['bookID']) => {
    const loginCredentials = window.localStorage.getItem('token')

    const { data } = await httpClient.post<Likes>(
      `/likes/${id}`,
      { data: null },
      {
        headers: {
          Authorization: `Bearer ${loginCredentials}`
        }
      }
    )

    return data
  }

  const del = async (id: Likes['id']) => {
    const { data } = await httpClient.delete<Likes>(`/likes/${id}`)
    return data
  }

  return { list, retrieve, create, del }
}
