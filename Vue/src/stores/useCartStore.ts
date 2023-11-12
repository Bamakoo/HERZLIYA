import { defineStore } from 'pinia'
import { ref, watch } from 'vue'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import { useAccountStore } from './useAccountStore'
import type { Users } from '@/libs/interfaces/users'
import type { Books } from '@/libs/interfaces/books'
import type { Cart } from '@/libs/interfaces/carts'

export const useCartStore = defineStore('cart', () => {
  const { retrieve } = useFetchCart()
  const accountStore = useAccountStore()

  const cart = ref<Cart>()
  /* A REVOIR !

  watch(
    cart,
    async (newBook) => {
      cart.value = await retrieve(accountStore.token)
      cart.value.books.push(newBook)
      return cart.value
    },
    { deep: true }
  )
  
  */
  console.log('cart :', cart.value?.books)
  return { cart }
})
