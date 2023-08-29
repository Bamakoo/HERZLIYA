import type { Users } from './users'
import type { Books } from './books'

export interface Cart {
  id: string
  user_id: Users['id']
  books: Books[] //id, price, state, seller, isAvailable, img, author
  total: number
  purchased_at: Date | number | null
  updatedAt: Date | number | null
  deletedAt: Date | number | null
}
