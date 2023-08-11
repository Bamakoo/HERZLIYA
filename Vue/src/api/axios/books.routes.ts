import axios from 'axios'
import type { Books } from '@/libs/interfaces/books'
import type { Users } from '@/libs/interfaces/users'

export const fetchBook = async () => {
  const token = 'token'
  const list = async () => {
    try {
      const { data } = await axios.get('/books')
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const get = async (id: Books['id']) => {
    try {
      const { data } = await axios.get(`/books/${id}`)
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const create = async (datas: Partial<Books>) => {
    try {
      const res = await axios.post('/books', datas, {
        headers: { Authorization: `Bearer ${token}` }
      })
      return res.data
    } catch (err) {
      return (err as Error).message
    }
  }

  const update = async (user_id: Users['id'], datas: Partial<Books>) => {
    try {
      if (user_id !== datas.seller) return
      const res = await axios.patch(
        `/books/${datas.id}`,
        { data: datas },
        { headers: { Authorization: `Bearer ${token}` } }
      )
      return res.data
    } catch (err) {
      return (err as Error).message
    }
  }

  const del = async (user: Users, id: Books['id']) => {
    try {
      if (user.books.find((book_id) => book_id !== id)) return
      const res = await axios.delete(`/books/${id}`, {
        headers: { Authorization: `Bearer ${token}` }
      })
      return res.data
    } catch (err) {
      return (err as Error).message
    }
  }

  return { list, get, create, update, del }
}
