import type { Books } from './books'
import type { Users } from './users'

export interface Likes {
  id: string
  userID: Users['id']
  bookID: Books['id']
  createdAt: Date | number
  updatedAt: Date | number | null
  deletedAt: Date | number | null
}
