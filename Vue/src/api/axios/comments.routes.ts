import type { Comments } from '@/libs/interfaces/comments'
import type { Users } from '@/libs/interfaces/users'
import axios from 'axios'

export const fetchComments = async () => {
  const token = 'token'
  const list = async () => {
    const { data } = await axios.get('/comments')
    return data
  }

  const get = async (id: Comments['id']) => {
    const { data } = await axios.get(`/comments/${id}`)
    return data
  }

  const post = async (user: Users['id'], datas: Comments) => {
    try {
      if (user !== datas.author) return
      const { data } = await axios.post('/comments', {
        data: datas,
        headers: { Authorization: `Bearer ${token}` }
      })
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const update = async (user: Users['id'], id: Comments['id'], datas: Comments) => {
    try {
      if (user !== datas.author) return
      const { data } = await axios.patch(`/comments/${id}`, {
        data: datas,
        headers: { Authorization: `Bearer ${token}` }
      })
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const del = async (user: Users['id'], id: Comments['id'], datas: Comments) => {
    try {
      if (user !== datas.author) return
      const { data } = await axios.delete(`/comments/${datas.id}`, {
        headers: {
          Authorization: `Bearer ${token}`
        }
      })
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  return { list, get, post, update, del }
}
