import { defineStore } from 'pinia'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import type { Users } from '@/libs/interfaces/users'

export const useCartStore = defineStore('cart', () => {
  const fetchCart = useFetchCart()

  const retrieveCart = (token: Users['token']) => {
    const data = fetchCart.retrieve(token)
    return data
  }

  return { retrieveCart }
})
