import { ref } from 'vue'
import httpClient from './httpClient'
// import { useAccountStore } from '@/stores/useAccountStore'
import type { Books } from '@/libs/interfaces/books'

export const useFetchBooks = async () => {
  const baseURL = '/api/books'
  // const accountStore = useAccountStore()

  const token = ref('') // doit avoir le token du compte de la session
  // token.value = (await accountStore.fetchAccount()).account.token
  const list = async () => httpClient.get<Books[]>(baseURL)

  const getBook = async (id: Books['id']) => httpClient.get<Books>(`${baseURL}/${id}`)

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
