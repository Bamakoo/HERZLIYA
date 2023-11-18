import { computed, ref, watch } from 'vue'
import { defineStore } from 'pinia'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import type { Users } from '@/libs/interfaces/users'

export const useAccountStore = defineStore('users', () => {
  const token = ref('')
  const id = ref('')
  const {
    profile: { infos, likes, purchases }
  } = useFetchAccounts()

  if (localStorage.getItem('token')) {
    token.value = localStorage.getItem('token') as string
  }

  watch(
    token,
    (newToken) => {
      localStorage.setItem('token', newToken)
      token.value = newToken
    },
    { deep: true }
  )

  const account = ref<Partial<Users>>({
    id: id.value,
    token: token.value,
    username: null,
    email: null,
    favoriteBook: null,
    favoriteAuthor: null,
    city: null,
    country: null,
    books: [],
    purchases: [],
    sales: [],
    friends: [],
    cart: undefined
  })

  const fetchUserData = computed(() => {
    const metadatas = async () => {
      try {
        account.value = await infos()
        account.value.purchases = await purchases()
        account.value.likes = await likes()

        return account.value
      } catch (error) {
        throw new Error((error as Error).message)
      }
    }
    return metadatas
  })

  return {
    token,
    id,
    account,
    fetchUserData
  }
})
