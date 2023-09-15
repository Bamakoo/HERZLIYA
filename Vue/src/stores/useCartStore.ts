import { defineStore } from 'pinia'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import type { Cart } from '@/libs/interfaces/carts'
import type { Books } from '@/libs/interfaces/books'

export const useCartStore = defineStore('cart', () => {
  const fetchCart = useFetchCart()

  const retrieveCart = (user_id: Cart['id']) => {
    const data = fetchCart.retrieve(user_id)
    return data
  }

  const createCart = (books: Books[]) => {
    const data = fetchCart.create(books)
    return data
  }

  return { retrieveCart, createCart }
})
