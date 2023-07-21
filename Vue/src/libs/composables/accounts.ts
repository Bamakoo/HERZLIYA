import { ref } from 'vue'
import type { Users } from '../interfaces/users'
import type { Books } from '../interfaces/books'

const accoutStore = ref<{
  isAutheticated: boolean
  account: {
    id: Users['id']
    firstname: string
    lastname: string
    username: Users['username']
    address: string
    zip_code: string
    country: Users['country']
    email: Users['email']
  }
  orders: {
    purchases: [
      {
        seller: Books['buyer']
        books: [
          { id: Books['id']; sold_date: Date | number | string; price: number; state: string }
        ]
        order_number: number | string
      }
    ]
    sales: [
      {
        buyer: string
        books: [{ id: string; sold_date: Date | number | string; price: number; state: string }]
        order_number: number | string
      }
    ]
  }
}>()
