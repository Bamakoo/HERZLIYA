import type { Users } from './users'
// export interface Books {
//   id: string
//   title: string
//   author: string
//   genre:
//     | 'fantasy '
//     | 'scienceFiction '
//     | 'action '
//     | 'mystery '
//     | 'horror '
//     | 'romance '
//     | 'realism '
//     | 'biography'

//   state:
//     | 'horrendous'
//     | 'bad'
//     | 'okay'
//     | 'passable'
//     | 'acceptable'
//     | 'good'
//     | 'excellent'
//     | 'brandNew'

//   description: string
//   img: string
//   price: number
//   seller: Users['id']
//   buyer?: Users['id']
//   status: 'available' | 'purchased' | 'inTransit' | 'delivered' | null
//   isFavorite: boolean
//   createdAt: Date
//   updatedAt?: Date | null
//   deletedAt?: Date | null
// }
export interface Books {
  id: string
  title: string
  author: string
  state: string
  price: number
}
