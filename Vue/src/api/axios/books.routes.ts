import axios from 'axios'
import type { Books } from '@/libs/interfaces/books'

export const fetchBook = async () => {
  const get = async () => {
    const { data } = await axios.get('/books')
    return data
  }

  const create = async (datas: Books) => {
    const res = await axios.post('/books', datas, {
      headers: { 'Content-Type': 'application/json' }
    })
    return res.data
  }

  const update = async (datas: Partial<Books>) => {
    const res = await axios.patch(`/books/${datas.id}`, { data: datas })
    return res.data
  }

  const del = async (id: Books['id']) => {
    const res = await axios.delete(`/books/${id}`)
    return res.data
  }

  return { get, create, update, del }
}
