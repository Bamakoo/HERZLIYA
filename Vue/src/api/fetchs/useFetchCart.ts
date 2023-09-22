import type { Books } from '@/libs/interfaces/books'
import httpClient from '../httpClient'
import type { Cart } from '@/libs/interfaces/carts'

export const useFetchCart = () => {
  const retrieve = async () => {
    const { data } = await httpClient.get<Cart>('/users/cart/')
    return data
  }

  const addToCart = async (id: Books['id'], datas: Books) => {
    const { data } = await httpClient.post<Books>(`/books/${id}/add-to-kart`, datas)
    return data
  }
  const update = async (id: Cart['id'], datas: Omit<Cart, 'id'>) => {
    const { data } = await httpClient.patch<Partial<Cart>>(`/users/cart/${id}`, datas)
    return data
  }

  const del = async (id: Cart['id']) => {
    const { data } = await httpClient.delete<Cart>(`/books/${id}/remove-from-kart`)
    return data
  }

  return { retrieve, addToCart, update, del }
}
