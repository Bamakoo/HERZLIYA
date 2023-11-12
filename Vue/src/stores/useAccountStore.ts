import { computed, ref, watch } from 'vue'
import { defineStore } from 'pinia'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import type { Users } from '@/libs/interfaces/users'

export const useAccountStore = defineStore('users', () => {
  const token = ref('')
  const id = ref('')

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
    id: undefined,
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

  const fetchUserData = async () => {
    try {
      const fetchUsers = useFetchAccounts()
      account.value = await fetchUsers.retrieve(token.value)
      console.log(`account.value Store : ${account.value}`)
      return account.value
    } catch (error) {
      throw new Error((error as Error).message)
    }
  }

  return {
    token,
    id,
    account,
    fetchUserData
  }
})
