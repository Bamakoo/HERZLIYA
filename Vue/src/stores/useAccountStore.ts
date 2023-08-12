import { defineStore } from 'pinia'
import { useFetchAccounts } from '../api/axios/user.api'
import type { Users } from '@/libs/interfaces/users'

export const useAccountStore = defineStore('account', {
  state: () => ({ accounts: [] as Users[] }),

  getters: {
    getAllAccounts(state) {
      return state.accounts
    }
  },
  actions: {
    async fetchAccounts() {
      const { list } = await useFetchAccounts()
      return list
    },
    async fetchAccount(id: Users['id']) {
      const fetchAccounts = await useFetchAccounts()
      const { retrieve } = fetchAccounts
      try {
        const { data } = await retrieve(id)
        const { books, cart, purchases, sales } = data
        const account = {
          username: data.username,
          email: data.email,
          country: data.country,
          city: data.city,
          token: data.token
        }

        const metadatas = {
          favoriteAuthor: data.favoriteAuthor,
          favoriteBook: data.favoriteBook,
          friends: data.friends,
          likes: data.likes,
          comments: data.comments
        }

        return { books, cart, purchases, sales, account, metadatas }
      } catch (error) {
        throw new Error((error as Error).message)
      }
    }
  }
})
