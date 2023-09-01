import type { Books } from './books'
import { type Users } from './users'
export interface Comments {
  id: string
  author: Users['id']
  book: Books['id']
  content: string
  createdAt: Date
  updatedAt: Date
  deletedAt: Date
}
