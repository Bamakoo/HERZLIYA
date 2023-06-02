import axios from 'axios'
import type { Books } from '@/libs/interfaces/books'

export const fetchBook = async () => {
  const get = async () => {
    const { data } = await axios.get('/books')
    return { data }
  }

  const create = async (datas: Books) => {
    const res = await axios.post('/books', {
      headers: { 'Content-Type': 'application/json' },
      data: { datas }
    })
    return res
  }

  const update = async (datas: Partial<Books>) => {
    const res = (await axios.patch(`/books/:${datas.id}`, { data: { datas } })) as Books
    return res
  }
  const del = async (id: Books['id']) => {
    const res = await axios.delete(`/books/:${id}`)
    const { data } = res
    return { data }
  }

  return { get, create, update, del }
}
