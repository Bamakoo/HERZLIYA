import type { Books } from '@/libs/interfaces/books'
import httpClient from '../httpClient'
import type { Cart } from '@/libs/interfaces/carts'

export const useFetchCart = () => {
  const retrieve = async () => {
    const { data } = await httpClient.get<Cart['books']>('/users/cart/')
    return data
  }

  const addToCart = async (bookId: Books['id']) => {
    const { data } = await httpClient.post<Books>(`/books/${bookId}/add-to-kart`, null)
    return data
  }
  const purchase = async (id: Cart['id']) => {
    const { data } = await httpClient.patch<Partial<Cart>>(`/books/${id}/purchase`, id)
    return data
  }

  const del = async (id: Cart['id']) => {
    const { data } = await httpClient.delete<Cart>(`/books/${id}/remove-from-kart`)
    return data
  }

  return { retrieve, addToCart, purchase, del }
}
