import type { Books } from '@/libs/interfaces/books'
import httpClient from '../httpClient'
import type { Cart } from '@/libs/interfaces/carts'

export const useFetchCart = () => {
  const retrieve = async (id: Cart['id']) => {
    const { data } = await httpClient.get<Cart>(`/cart/${id}`)
    return data
  }

  const create = async (datas: Omit<Cart, 'id'>) => {
    const { data } = await httpClient.post<Cart>('/cart', datas)
    return data
  }

  const update = async (id: Cart['id'], datas: Omit<Cart, 'id'>) => {
    const { data } = await httpClient.patch<Partial<Cart>>(`/cart/${id}`, datas)
    return data
  }

  const del = async (id: Cart['id']) => {
    const { data } = await httpClient.delete<Cart>(`/cart/${id}`)
    return data
  }
  // const delItem = async (id: Cart['id'], book_id:Books['id']) => { SUPPRIMER UN LIVRE DU PANIER DANS L'UPDATE ?
  //   const { data } = await httpClient.delete<Cart>(`/cart/${id}`)
  //   return data
  // }

  return { retrieve, create, update, del }
}