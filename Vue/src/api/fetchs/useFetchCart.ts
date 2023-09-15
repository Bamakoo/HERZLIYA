import type { Books } from '@/libs/interfaces/books'
import httpClient from '../httpClient'
import type { Cart } from '@/libs/interfaces/carts'

export const useFetchCart = () => {
  const retrieve = async (id: Cart['id']) => {
    const { data } = await httpClient.get<Cart>(`/kart/${id}`)
    return data
  }

  const create = async (datas: Books[]) => {
    const { data } = await httpClient.post<Cart>('/kart', datas)
    return data
  }

  const update = async (id: Cart['id'], datas: Omit<Cart, 'id'>) => {
    const { data } = await httpClient.patch<Partial<Cart>>(`/kart/${id}`, datas)
    return data
  }

  const del = async (id: Cart['id']) => {
    const { data } = await httpClient.delete<Cart>(`/kart/${id}`)
    return data
  }
  // const delItem = async (id: Cart['id'], book_id:Books['id']) => { SUPPRIMER UN LIVRE DU PANIER DANS L'UPDATE ?
  //   const { data } = await httpClient.delete<Cart>(`/kart/${id}`)
  //   return data
  // }

  return { retrieve, create, update, del }
}
