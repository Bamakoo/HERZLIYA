import { ref } from 'vue'
import { defineStore } from 'pinia'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import type { Users } from '@/libs/interfaces/users'

export const useAccountStore = defineStore('users', () => {
  const fetchUsers = useFetchAccounts()
  const userList = fetchUsers.list()

  const retrieveUserAccount = async (id: Users['id']) => {
    try {
      const user = await fetchUsers.retrieve(id) // Attendre la résolution de la promesse
      return user
    } catch (error) {
      throw new Error((error as Error).message)
    }
  }

  const id = ref('')
  const userAccount = ref<Partial<Users> | null>(null)
  const token = ref<Users['token']>('')

  // const account = {
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
  // }
  retrieveUserAccount(id.value).then((user) => {
    // Une fois la promesse résolue, mettez les données dans account
    const account = {
      infos: {
        id: user.id,
        token: user.token,
        username: user.username,
        email: user.email,
        favoriteBook: user.favoriteBook,
        favoriteAuthor: user.favoriteAuthor,
        city: user.city,
        country: user.country
      },
      books: user.books,
      purchases: user.purchases,
      sales: user.sales,
      friends: user.friends
    }

    // Mettez à jour userAccount
    userAccount.value = account
    token.value = account.infos.token
  })

  return { userList, retrieveUserAccount, token, userAccount }
})
