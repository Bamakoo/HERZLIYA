import httpClient from '../httpClient'
import type { Comments } from '@/libs/interfaces/comments'
import type { Books } from '@/libs/interfaces/books'

export const useFetchComments = () => {
  const list = async () => {
    const { data } = await httpClient.get<Comments>('/comments')
    return data
  }

  const retrieve = async (bookId: Books['id']) => {
    const { data } = await httpClient.get<Comments>(`/comments/${bookId}`)
    return data
  }

  const create = async (datas: Omit<Comments, 'id' | 'createdAt' | 'updatedAt' | 'deletedAt'>) => {
    const { data } = await httpClient.post<Comments>('/comments', datas)
    return data
  }

  const update = async (commentId: Comments['id'], datas: Omit<Comments, 'id'>) => {
    const { data } = await httpClient.patch<Comments>(`/comments/${commentId}`, datas)
    return data
  }

  const del = async (id: Comments['id']) => {
    const { data } = await httpClient.delete<Comments>(`/comments/${id}`)
    return data
  }

  return { list, retrieve, create, update, del }
}
