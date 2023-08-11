import { defineStore } from 'pinia'
// import { getAllBooks } from '@/api/axios/books.api'
import type { Books } from '@/libs/interfaces/books'
// import { getAllBooks } from '@/api/axios/books.api'
import axios from 'axios'
// export const useBooksStore = defineStore('booksStore', {
//   state: () => ({
//     books: [
//       {
//         id: '1',
//         title: 'Harry Potter',
//         author: 'J.K.Rolling',
//         genre: 'fantastic',
//         state: 'Good',
//         description: 'description Harry Potter',
//         img: '../assets/book.jpg',
//         price: 12,
//         seller: 'Emma Gaubert',
//         buyer: 'Audrey Carmont',
//         status: true,
//         createdAt: Date.now(),
//         updatedAt: null,
//         deletedAt: null,
//         isFavorite: false,
//         isAvailable: true
//       },
//       {
//         id: '2',
//         title: 'La Petite Sirène',
//         author: 'Andersen',
//         genre: 'fantastic',
//         state: 'New',
//         description: 'description La petite Sirène',
//         img: '../assets/book.jpg',
//         price: 12,
//         seller: 'Emma Gaubert',
//         buyer: 'Audrey Carmont',
//         status: true,
//         createdAt: Date.now(),
//         updatedAt: null,
//         deletedAt: null,
//         isFavorite: false,
//         isAvailable: true
//       },
//       {
//         id: '3',
//         title: 'Lulu Vroumette',
//         author: 'M.Paf',
//         genre: 'fantasy',
//         state: 'Good',
//         description: 'description Lulu Vroumette',
//         img: '../assets/book.jpg',
//         price: 12,
//         seller: 'Emma Gaubert',
//         buyer: 'Audrey Carmont',
//         status: true,
//         createdAt: Date.now(),
//         updatedAt: null,
//         deletedAt: null,
//         isFavorite: true,
//         isAvailable: true
//       }
//     ]
//   }),
//   getters: {
//     favs(state) {
//       return state.books.filter((book) => book.isFavorite)
//     },
//     booksCount(state) {
//       return state.books.length
//     }
//   }
//   // actions: {
//   //   addBook(book_id: Books['id']) {
//   //     this.books.push(book_id)
//   //   },
//   //   async fetchBooks({ commit }) {
//   //     try {
//   //       const response = await getAllBooks()
//   //       commit('SET_USERS', response.data)
//   //     } catch (error) {
//   //       throw new Error((error as Error).message)
//   //     }
//   //   }
//   // }

//   // actions : async () => {
//   //   await fetchBooks({ commit }) {
//   //           try {
//   //               const response = await getAllBooks()
//   //               commit('SET_BOOKS', response.data)
//   //           } catch (error) {
//   //               // handle the error here
//   //           }
//   //       }
//   //   },

//   //  mutations : {
//   //     SET_BOOKS(state, data) {
//   //         state.books = data;
//   //     }
//   // },

//   // return {
//   //     namespaced: true,
//   //     state,
//   //     getters,
//   //     actions,
//   //     mutations
//   // }
// })

/**
 * title: string | null
  author: string | null
  genre:
    | 'fantasy '
    | 'scienceFiction '
    | 'action '
    | 'mystery '
    | 'horror '
    | 'romance '
    | 'realism '
    | 'biography'
    | null
  state:
    | 'horrendous'
    | 'bad'
    | 'okay'
    | 'passable'
    | 'acceptable'
    | 'good'
    | 'excellent'
    | 'brandNew'
    | null
  description: string | undefined
  price: number | null
  seller?: Users['id']
  buyer?: Users['id'] | null
  status: 'available' | 'purchased' | 'inTransit' | 'delivered' | null
  createdAt: Date
  updatedAt?: Date | null
  deletedAt?: Date | null
 */

export const useBooksStore = defineStore('books', {
  state: () => ({
    books: [] as Books[]
  }),
  getters: {
    getAllBooks(state) {
      return state.books
    }
  },
  actions: {
    async fetchBooks() {
      try {
        const data = await (await axios.get('/books')).data
        this.books = JSON.parse(JSON.stringify({ data }))
      } catch (error) {
        alert((error as Error).message)
        console.error((error as Error).message)
      }
    }
  }
})
