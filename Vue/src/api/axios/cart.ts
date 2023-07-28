import type { Cart } from '@/libs/interfaces/cart'
import type { Books } from '@/libs/interfaces/books'
import type { Users } from '@/libs/interfaces/users'
import axios from 'axios'
import { fetchUsers } from './users.routes'

export const fetchCart = async () => {
  const token = 'token'
  const { get: user_id } = await fetchUsers()

  const get = async () => {
    try {
      // if(user_id !=== ) return // si l'id du proprio du panier est différent de celui de l'utilisateur de la session => return
      const { data } = await axios.get(`/kart/${user_id}`, {
        method: 'GET',
        headers: { Authorization: `Bearer ${token}` }
      })
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const create = async (datas: Cart['books']) => {
    try {
      const { data } = await axios.post(
        `/kart/${user_id}`,
        { data: datas },
        { headers: { Authorization: `Bearer ${token}` } }
      )
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const update = async (datas: Partial<Cart>) => {
    try {
      const { data } = await axios.patch(
        `/kart/${user_id}`,
        { data: datas },
        { headers: { Authorization: `Bearer ${token}` } }
      )
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  //PAS DE ELETE AR SUPRIME TOUT LE PANIER => VEUX QUE SUPPRIMER UN ÉLÉMENT DU PANIER => SE FAIT DANS L'UPDATE + LÀ OÙ EST APPELEÉ LUPDATE : FONCTION QUI RPEND L'ID DE L'ITEM EN ARGUMENT ?
  // const del = async () => {
  //   try {
  //     // if(user_id !=== ) return // si l'id du proprio du panier est différent de celui de l'utilisateur de la session => return

  //     const { data } = await axios.delete(`/kart/${user_id}`, {
  //       headers: { Authorization: `Bearer ${token}` }
  //     })

  //   } catch (err) {
  //     return (err as Error).message
  //   }
  // }

  return { get, create, update }
  //delete : supprimer un item à un index particulier
}
