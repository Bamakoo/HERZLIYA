import { ref } from 'vue'
import type { Users } from '../interfaces/users'
import type { Books } from '../interfaces/books'
import type { Comments } from '../interfaces/comments'

const accoutStore = ref<{
  isAutheticated: boolean
  account: {
    id: Users['id']
    // firstname: string
    // lastname: string
    username: Users['username']
    // address: string
    // zip_code: string
    city: Users['city']
    country: Users['country']
    email: Users['email']
  }
  comments: [
    {
      id: Comments['id']
      book_id: Comments['book']
      content: Comments['content']
      rating: number
      created_at: Comments['createdAt']
      updated_at: Comments['updatedAt']
    }
  ]
  orders: {
    purchases: [
      {
        seller: Books['buyer']
        books: [{ id: Books['id']; sold_at: Date | number; price: number; state: string }]
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
  friends: [
    {
      id: Users['id']
      username: Users['username']
      isFriend: boolean
    }
  ]
  favorite_book: [{ id: Books['id']; title: Books['title']; author: Books['author'] }]
  favorite_author: [{ id: string; name: string }]
}>()

export default accoutStore
