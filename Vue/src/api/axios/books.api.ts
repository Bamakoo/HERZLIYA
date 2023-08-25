import { ref } from 'vue'
import httpClient from './httpClient'
// import { useAccountStore } from '@/stores/useAccountStore'
import type { Books } from '@/libs/interfaces/books'

export const useFetchBooks = () => {
  const baseURL = '/books'
  // const accountStore = useAccountStore()

  const token = ref('') // doit avoir le token du compte de la session
  // token.value = (await accountStore.fetchAccount()).account.token
  const list = async () => {
    const { data } = await httpClient.get<Books[]>(baseURL)
    return data
  }

  const getBook = async (id: Books['id']) => {
    const { data } = await httpClient.get<Books>(`${baseURL}/${id}`)
    return data
  }

  const update = async (id: Books['id'], data: Omit<Books, 'id'>) => {
    const book = httpClient.patch<Partial<Books>>(`${baseURL}/${id}`, data, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
    return book
  }

  const create = async (data: Omit<Books, 'id'>) => {
    const book = httpClient.post(baseURL, data, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
    return book
  }

  const del = async (id: Books['id']) => {
    httpClient.delete<Books>(`${baseURL}/${id}`, {
      headers: { Authorization: `Bearer ${token.value}` }
    })
  }

  return { list, getBook, update, del, create }
}
