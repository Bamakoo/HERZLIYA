export interface Books {
  id: string
  author: string | null
  title: string | null
  price: string | null
  state:
    | 'horrendous'
    | 'bad'
    | 'okay'
    | 'passable'
    | 'acceptable'
    | 'good'
    | 'excellent'
    | 'brandNew'
}
