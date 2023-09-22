import { defineStore } from 'pinia'
import { useFetchCart } from '@/api/fetchs/useFetchCart'

export const useCartStore = defineStore('cart', () => {
  const fetchCart = useFetchCart()

  const retrieveCart = () => {
    const data = fetchCart.retrieve()
    return data
  }

  return { retrieveCart }
})
