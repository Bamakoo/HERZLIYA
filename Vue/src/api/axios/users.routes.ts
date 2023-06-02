import axios from 'axios'
import type { Users } from '@/libs/interfaces/users'

export const fetchUsers = async () => {
  const listUsers = async () => {
    const { data } = await axios.get('/users', {
      headers: { 'Content-Type': 'application/json' }
    })
    return data
  }

  const getUser = async (id: Users['id']) => {
    const { data } = await axios.get(`/users/${id}`, {
      headers: { 'Content-Type': 'application/json' }
    })
    return data
  }

  const create = async (datas: Users) => {
    const res = await axios.post('/users', {
      data: { datas },
      headers: { 'Content-Type': 'application/json' }
    })
    return res
  }
  const update = async (datas: Partial<Users>) => {
    const res = await axios.patch(`/users/:${datas.id}`, {
      data: { datas },
      headers: { 'Content-Type': 'application/json' }
    })
    return res
  }
  const del = async (datas: Users) => {
    const res = await axios.delete(`users/${datas.id}`, { data: { datas } })
    return res
  }
  return { listUsers, getUser, create, update, del }
}
