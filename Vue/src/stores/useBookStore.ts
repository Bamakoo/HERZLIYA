import { defineStore } from 'pinia'
import { useFetchBooks } from '@/api/fetchs/useFetchBooks'
import type { Books } from '@/libs/interfaces/books'

export const useBookStore = defineStore('books', () => {
  const fetchBooks = useFetchBooks()

  const books = fetchBooks.list()

  const retrieveBook = (id: Books['id']) => {
    const book = fetchBooks.retrieve(id)
    return book
  }

  return { books, retrieveBook }
})
