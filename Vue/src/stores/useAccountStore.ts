import { computed, ref, watch } from 'vue'
import { defineStore } from 'pinia'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import type { Users } from '@/libs/interfaces/users'

export const useAccountStore = defineStore('users', () => {
  const token = ref('')
  const id = ref('')
  const { list, retrieve } = useFetchAccounts()

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

  const fetchUserData = async () => {
    try {
      account.value = (await list()).find((user) => user.token === token.value)
      console.log(`infos.value Store : ${account.value}`)

      const infos = computed(() => {
        return account.value
      })
      console.log(`infos.value Store : ${infos.value}`)
      return infos.value
    } catch (error) {
      throw new Error((error as Error).message)
    }
  }
  console.log('fetchUserData Store', async () => await fetchUserData())
  return {
    token,
    id,
    account,
    fetchUserData
  }
})
