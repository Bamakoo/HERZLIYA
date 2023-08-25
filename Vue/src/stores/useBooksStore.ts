import { defineStore } from 'pinia'
import { useFetchBooks } from '@/api/axios/books.api'
import type { Books } from '@/libs/interfaces/books'
// import { ref } from 'vue'
// import axios from 'axios'
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

// export const useBooksStore = defineStore('books', {
//   state: () => ({
//     books: [] as Books[]
//   }),
//   getters: {
//     getAllBooks(state) {
//       return state.books
//     }
//   },
//   actions: {
//     async fetchBooks() {
//       try {
//         const { data } = await axios.get('/api/books')
//         this.books = JSON.parse(JSON.stringify({ data }))
//       } catch (error) {
//         alert((error as Error).message)
//         console.error((error as Error).message)
//       }
//     }
//   }
// })

export const useBooksStore = defineStore('books', () => {
  // state: () => ({
  //   books: [] as Books[]
  // }),
  // getters: {
  //   getAllBooks(state) {
  //     return state.books
  //   }
  // },
  // actions: {
  //   async list() {
  //     const { list } = await useFetchBooks()
  //     return list
  //   },
  //   async fetchBook(id: Books['id']) {
  //     // try {
  //     //   const { getBook } = await useFetchBooks()
  //     //   this.books = data
  //     //   // return JSON.parse(JSON.stringify(this.books))
  //     //   // this.books = data.map((book: Books[]) => ({ ...book }))
  //     //   this.books.map((book) => {
  //     //     book.author = data.author
  //     //   })
  //     //   return this.books
  //     // }
  //     try {
  //       const { getBook } = await useFetchBooks()
  //       const { data } = await getBook(id)
  //       return data
  //     } catch (error) {
  //       alert(error)
  //       console.error((error as Error).message)
  //     }
  //   }
  // }
  const fetchBooks = useFetchBooks()
  const bookList = fetchBooks.list()

  const retrieveBook = (id: Books['id']) => fetchBooks.getBook(id)
  return { bookList, retrieveBook }
})

//SOLUTION 3
// export const useBookStore = defineStore('books', async () => {
// const fetchBook = await useFetchBooks()
// // const { list } = fetchBook
// const books = ref<Books[]>([])
// // books.value = await list()
//   return {books}
// })
