import type { Books } from '@/libs/interfaces/books'
import httpClient from '../httpClient'
import type { Cart } from '@/libs/interfaces/carts'
import type { Users } from '@/libs/interfaces/users'

export const useFetchCart = () => {
  const retrieve = async (token: Users['token']) => {
    const { data } = await httpClient.get<Cart>('/users/cart/', {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    return data
  }

  const addToCart = async (bookId: Books['id']) => {
    const loginCredentials = window.localStorage.getItem('token') ?? 'b5ZvjMmJQNbgzcCahIm6uA=='
    const { data } = await httpClient.post<Books>(`/books/${bookId}/add-to-kart`, null, {
      headers: { Authorization: `Bearer ${loginCredentials}` }
    })
    return data
  }
  const update = async (token: Users['token'], id: Cart['id'], datas: Omit<Cart, 'id'>) => {
    const { data } = await httpClient.patch<Partial<Cart>>(`/users/cart/${id}`, datas, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return data
  }

  const del = async (token: Users['token'], id: Cart['id']) => {
    const { data } = await httpClient.delete<Cart>(`/books/${id}/remove-from-kart`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return data
  }

  return { retrieve, addToCart, update, del }
}
