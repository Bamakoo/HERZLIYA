import { defineStore } from 'pinia'
import { ref, watch } from 'vue'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import type { Cart } from '@/libs/interfaces/carts'

export const useCartStore = defineStore('cart', () => {
  const { retrieve } = useFetchCart()

  const cart = ref<Cart['books']>()

  watch(
    cart,
    async (newBook) => {
      cart.value = await retrieve()
      if (newBook) cart.value = newBook
      return cart.value
    },
    { deep: true }
  )

  return { cart }
})
