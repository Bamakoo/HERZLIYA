import { ref } from 'vue'
import { fetchUsers } from '@/api/axios/users.routes'
import type { Users } from '../interfaces/users'
import type { Books } from '../interfaces/books'
import type { Comments } from '../interfaces/comments'

const { get } = await fetchUsers()

const fetchAccount = async (id: Users['id']) => {
  const data = await get(id)

  const accountStore = ref<{
    isAutheticated: boolean
    account: {
      id: Users['id']
      // firstname: string
      // lastname: string
      username: Users['username']
      email: Users['email']
      // address: string
      // zip_code: string
      city: Users['city']
      country: Users['country']
    }
    comments: [
      {
        id: Comments['id']
        book_id: Comments['book']
        content: Comments['content']
        rating: number
        created_at: Comments['createdAt']
        updated_at: Comments['updatedAt']
      }
    ]
    orders: {
      purchases: [
        {
          seller: Books['buyer']
          books: [{ id: Books['id']; sold_at: Date | number; price: number; state: string }]
          order_number: number | string
        }
      ]
      sales: [
        {
          buyer: string
          books: [{ id: string; sold_at: Date | number | string; price: number; state: string }]
          order_number: number | string
        }
      ]
    }
    friends: [
      {
        id: Users['id']
        username: Users['username']
        isFriend: boolean
      }
    ]
    favorite_book: [{ id: Books['id']; title: Books['title']; author: Books['author'] }]
    favorite_author: [{ id: string; name: string }]
  }>({
    isAutheticated: data.token ?? false,
    account: {
      id: data.id,
      // firstname: string
      // lastname: string
      username: data.username,
      email: data.email,
      // address: string
      // zip_code: string
      city: data.city,
      country: data.country
    },
    comments: [
      {
        id: data.comments.id,
        book_id: data.comments.book,
        content: data.comments.content,
        rating: data.comments.rating,
        created_at: data.comments.created_at,
        updated_at: data.comments.updated_at
      }
    ],
    orders: {
      purchases: [
        {
          seller: data.orders.purchases.seller,
          books: [
            {
              id: data.orders.purchases.book,
              sold_at: data.orders.purchases.sold_at,
              price: data.orders.purchases.price,
              state: data.orders.purchases.book.state
            }
          ],
          order_number: data.orders.purchases.id
        }
      ],
      sales: [
        {
          buyer: data.orders.sales.buyer,
          books: [
            {
              id: data.orders.sales.books.id,
              sold_at: data.orders.sales.books.sold_at,
              price: data.orders.sales.books.price,
              state: data.orders.sales.books.state
            }
          ],
          order_number: data.orders.sales.id
        }
      ]
    },
    friends: [
      {
        id: data.friends.id,
        username: data.friends.username,
        isFriend: data.friends.id ?? false
      }
    ],
    favorite_book: [
      {
        id: data.favorite_book.id,
        title: data.favorite_book.title,
        author: data.favorite_book.author
      }
    ],
    favorite_author: [{ id: data.favorite_author.id, name: data.favorite_author.name }]
  })

  return { accountStore }
}
export default fetchAccount
