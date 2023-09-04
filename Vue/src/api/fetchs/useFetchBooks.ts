import httpClient from '../httpClient'
import type { Books } from '@/libs/interfaces/books'

export const useFetchBooks = () => {
  const list = async () => {
    const { data } = await httpClient.get<Books[]>('/books')
    return data
  }

  const retrieve = async (id: Books['id']) => {
    const { data } = await httpClient.get<Books>(`/books/${id}`)
    return data
  }

  const create = async (datas: Omit<Books, 'id'>) => {
    const data = await httpClient.post<Books>('/books', { data: datas })
    return data
  }

  // const update = async (id: Books['id'], datas: Omit<Books, 'id'>) => {
  //   const data = await httpClient.patch<Partial<Books>>(`/books/${id}`, { data: datas })
  //   return data
  // }

  // const del = async (id: Books['id']) => {
  //   const data = await httpClient.delete<Books>(`/books/${id}`)
  //   return data
  // }

  return { list, retrieve, create } //, update, del }
}
