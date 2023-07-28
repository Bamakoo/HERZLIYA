import axios from 'axios'
import type { Users } from '@/libs/interfaces/users'

export const fetchUsers = async () => {
  const token = 'token' //probablement stocké dans accountAstore => fetchAccount
  const list = async () => {
    try {
      const { data } = await axios.get('/users', {
        headers: { Authorization: `Bearer ${token}` }
      })
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const get = async (id: Users['id']) => {
    try {
      const { data } = await axios.get(`/users/${id}`, {
        headers: { Authorization: `Bearer ${token}` }
      })
      return data
    } catch (err) {
      return (err as Error).message
    }
  }

  const create = async (datas: Users) => {
    try {
      const res = await axios.post('/users', {
        data: datas
      })

      return res
    } catch (err) {
      return (err as Error).message
    }
  }
  const update = async (datas: Partial<Users>) => {
    try {
      const res = await axios.patch(`/users/:${datas.id}`, {
        data: { datas },
        headers: { Authorization: `Bearer ${token}` }
      })
      return res
    } catch (err) {
      return (err as Error).message
    }
  }

  const del = async (datas: Users) => {
    try {
      const res = await axios.delete(`users/${datas.id}`, {
        headers: { Authorization: `Bearer ${token}` }
      })
      return res
    } catch (err) {
      return (err as Error).message
    }
  }
  return { list, get, create, update, del }
}
