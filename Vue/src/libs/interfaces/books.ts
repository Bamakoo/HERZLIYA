export interface Books {
  id: string
  author: string | null
  title: string | null
  price: number
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
  genre:
    | 'fantasy'
    | 'scienceFiction'
    | 'action'
    | 'mystery'
    | 'horror'
    | 'romance'
    | 'realism'
    | 'biography'
    | null
  description: string | undefined
  createdAt: number | null
  updatedAt: number | null
  deletedAt: number | null
}
