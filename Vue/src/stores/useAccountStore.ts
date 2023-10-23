import { ref, watch } from 'vue'
import { defineStore } from 'pinia'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import type { Users } from '@/libs/interfaces/users'
import type { Books } from '@/libs/interfaces/books'

/* export const useAccountStore = defineStore('users', () => {
  const fetchUsers = useFetchAccounts()
  const userList = fetchUsers.list()

  const userAccount = ref<Partial<Users> | null>(null)

  const token = ref<Users['token']>(
    window.localStorage.getItem('token') ?? 'b5ZvjMmJQNbgzcCahIm6uA=='
  )

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

  const retrieveUserAccount = async (token: Users['token']) => {
    try {
      userAccount.value = await fetchUsers.retrieve(token as string)
      return userAccount.value
    } catch (error) {
      throw new Error((error as Error).message)
    }
  }
  // retrieveUserAccount(id.value).then((user) => {
  //     const account = {
  //       infos: {
  //         id: user.id,
  //         username: user.username,
  //         email: user.email,
  //         favoriteBook: user.favoriteBook,
  //         favoriteAuthor: user.favoriteAuthor,
  //         city: user.city,
  //         country: user.country
  //       },
  //       books: user.books,
  //       purchases: user.purchases,
  //       sales: user.sales,
  //       friends: user.friends,
  //       cart: user.cart
  //     }
  //     userAccount.value = account

  //     return userAccount.value
  //   })

  // watch(
  //   () => window.localStorage.getItem('token'), // Fonction qui renvoie la valeur actuelle du token dans le localStorage
  //   (newToken) => {
  //     token.value = newToken
  //   }
  // )
  // const { logout } = useFetchAccounts()

  return { userList, retrieveUserAccount, token, userAccount }
}) */
export const useAccountStore = defineStore('users', {
  state: (): Users => ({
    token: null,
    booksForSale: [],
    cart: []
  }),
  getters: {
    isAuthenticated: (state) => !!state.token
  },
  actions: {
    setToken(token: string | null) {
      this.token = token
    },
    setBooksForSale(books: Books[]) {
      this.booksForSale = books
    },
    addToCart(book: Books) {
      this.cart.push(book)
    },
    removeFromCart(book: Books) {
      const index = this.cart.findIndex((item) => item.id === book.id)
      if (index !== -1) {
        this.cart.splice(index, 1)
      }
    },
    clearCart() {
      this.cart = []
    }
  }
})
