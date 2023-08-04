import { defineStore } from 'pinia'
import axios from 'axios'
import type { Users } from '@/libs/interfaces/users'
import type { Books } from '@/libs/interfaces/books'
import { useFetchAccount } from './useFetchAccount'

export const useAccountStore = defineStore('account', () => {
  const fetchAccounts = useFetchAccounts()
  const fetchBooks = useFetchBooks()

  const token = localStorage.getItem('token')

  const books: Books[] = []

  const myBooks = async () => {
    const res = fetchAccounts.books
    return res
  }

  return { token, books, myBooks }
})
