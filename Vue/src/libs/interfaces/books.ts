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
}
