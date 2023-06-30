export interface Users {
  id: string | null
  username: string | null
  email: string | null
  favoriteBook?: string | null
  country: string | null
  city: string | null
  favoriteAuthor?: string | null
  createdAt: Date
  updatedAt: Date
}
