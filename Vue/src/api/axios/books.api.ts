import httpClient from './httpClient'
import fetchAccount from '@/libs/composables/accounts'

const END_POINT = '/books'

const getAllBooks = () => httpClient.get(END_POINT)

// const token = fetchAccount()

// you can pass arguments to use as request parameters/data
const getBook = (book_id: string) => httpClient.get(END_POINT, { data: { book_id } })
// maybe more than one..
const createBook = (token: string) =>
  httpClient.post(END_POINT, { headers: { Authorization: `Bearer ${token}` } })

export { getAllBooks, getBook, createBook }
