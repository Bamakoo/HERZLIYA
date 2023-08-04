// store/books.ts
import { defineStore } from 'pinia'
import api from '../api/api'
import type { Books } from '@/libs/interfaces/books'

export const useBooksStore = defineStore('books', {
  state: () => ({
    books: [] as Books[]
  }),
  actions: {
    async fetchBooks() {
      try {
        const response = await api.get<Books[]>('/books')
        this.books = response.data
      } catch (error) {
        console.error('Erreur lors de la récupération des livres :', error)
      }
    },
    async addBook(book: Books) {
      try {
        const response = await api.post<Books>('/books', book)
        this.books.push(response.data)
      } catch (error) {
        console.error("Erreur lors de l'ajout du livre :", error)
      }
    },
    async updateBook(book: Books) {
      try {
        await api.put(`/books/${book.id}`, book)
      } catch (error) {
        console.error('Erreur lors de la mise à jour du livre :', error)
      }
    },
    async deleteBook(bookId: string) {
      try {
        await api.delete(`/books/${bookId}`)
        this.books = this.books.filter((book) => book.id !== bookId)
      } catch (error) {
        console.error('Erreur lors de la suppression du livre :', error)
      }
    }
  }
})
