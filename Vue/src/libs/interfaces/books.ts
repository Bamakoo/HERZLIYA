import type { Users } from './users'
export interface Books {
  id: string | null
  title: string | null
  author: string | null
  genre:
    | 'fantasy '
    | 'scienceFiction '
    | 'action '
    | 'mystery '
    | 'horror '
    | 'romance '
    | 'realism '
    | 'biography'
    | null
  state:
    | 'horrendous'
    | 'bad'
    | 'okay'
    | 'passable'
    | 'acceptable'
    | 'good'
    | 'excellent'
    | 'brandNew'
    | null
  description: string | undefined
  price: number | null
  seller?: Users['id']
  buyer?: Users['id'] | null
  status: 'available' | 'purchased' | 'inTransit' | 'delivered' | null
  createdAt: Date
  updatedAt?: Date | null
  deletedAt?: Date | null
}
