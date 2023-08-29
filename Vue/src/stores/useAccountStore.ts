import { ref } from 'vue'
import { defineStore } from 'pinia'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import type { Users } from '@/libs/interfaces/users'

export const useAccountStore = defineStore('users', () => {
  const fetchUsers = useFetchAccounts()
  const userList = fetchUsers.list()

  const retrieveUserAccount = (id: Users['id']) => {
    const user = fetchUsers.retrieve(id)
    return user
  }

  const id = ref('')
  const userAccount = retrieveUserAccount(id.value)
  const token = ref('')

  // const account = ref({
  //   infos: {
  //     id: userAccount.id,
  //     username: userAccount.username,
  //     email: userAccount.email,
  //     favorite_book: userAccount.favoriteBook,
  //     favorite_author: userAccount.favoriteAuthor,
  //     city: userAccount.city,
  //     country: userAccount.country
  //   }, //password
  //   books: userAccount.books,
  //   purchases: userAccount.purchases,
  //   sales: userAccount.sales,
  //   friends: userAccount.friends
  // })

  return { userList, retrieveUserAccount } //account, token }
})
