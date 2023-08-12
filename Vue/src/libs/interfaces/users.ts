import type { Books } from './books'
import type { Cart } from './cart'
import type { Comments } from './comments'
import type { Likes } from './likes'

export interface Purchases {
  id: string
  books: Books[]
  seller: Users['id']
  date: Date | number | string
}

export interface Sales {
  id: string
  books: Books[]
  buyer: Users['id']
  date: Date | number | string
}

export interface Users {
  id: string | null
  token: string | null
  username: string | null
  email: string | null
  favoriteBook?: string | null
  country: string | null
  city: string | null
  favoriteAuthor?: string | null
  password: string | null
  confirmPassword: string | null
  createdAt: Date
  updatedAt: Date
  books: Books[]
  cart: Cart
  purchases: Purchases[]
  sales: Sales[]
  friends: Friends[]
  likes: Likes[]
  comments: Comments[]
}

export interface Friends {
  userId: string
  friendsId: Users['id'][]
}
