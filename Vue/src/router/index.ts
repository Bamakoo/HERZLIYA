import { createRouter, createWebHistory } from 'vue-router'
import Books from '../views/Books.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: Books
    },
    {
      path: '/add',
      name: 'add',
      component: () => import('../views/AddBook.vue')
    },
    {
      path: '/books/:id',
      name: 'book',
      component: () => import('@/views/BookDetails.vue')
    },
    {
      path: '/account',
      name: 'myAccount',
      component: () => import('@/views/Account.vue')
    },
    {
      path: '/account',
      name: 'accounts',
      component: () => import('@/views/AccountDetails.vue')
    },
    {
      path: '/cart',
      name: 'cart',
      component: () => import('@/views/Cart.vue')
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/Login.vue')
    },
    {
      path: '/signup',
      name: 'signup',
      component: () => import('@/views/Signup.vue')
    }
  ]
})

export default router
// import { createRouter, createWebHistory } from 'vue-router'

// const router = createRouter({
//   history: createWebHistory(import.meta.env.BASE_URL),
//   routes: [
//     {
//       path: '/',
//       name: 'home',
//       component: () => import('@/views/BooksView.vue')
//     },

//     {
//       path: '/add',
//       name: 'addBook',
//       // route level code-splitting
//       // this generates a separate chunk (Add.[hash].js) for this route
//       // which is lazy-loaded when the route is visited.
//       component: () => import('@/views/AddBook.vue')
//     },
//     {
//       path: '/account/:id',
//       name: 'account-parent',
//       component: () => import('@/views/AccountView.vue'),
//       children: [
//         {
//           path: '/profile',
//           component: () => import('@/components/Users/UserProfile.vue'),
//           name: 'profile'
//         },
//         {
//           path: '/comments',
//           component: () => import('@/components/Users/UserComments.vue'),
//           name: 'comments'
//         },
//         {
//           path: '/likes',
//           component: () => import('@/components/Users/UserLikes.vue'),
//           name: 'likes'
//         },
//         {
//           path: '/sales',
//           component: () => import('@/components/Users/UserSales.vue'),
//           name: 'sales'
//         },
//         {
//           path: '/purchases',
//           component: () => import('@/components/Users/UserPurchases.vue'),
//           name: 'purchases'
//         },
//         {
//           path: '/favoriteauthor',
//           component: () => import('@/components/Users/UserFavoriteAuthor.vue'),
//           name: 'favoriteauthor'
//         },
//         {
//           path: '/friends',
//           component: () => import('@/components/Users/UserFriends.vue'),
//           name: 'friends'
//         }
//       ]
//     },
//     {
//       path: '/kart',
//       name: 'kart',
//       component: () => import('@/views/CartView.vue')
//     },
//     {
//       path: '/book/**/*.vue',
//       name: 'book',
//       components: {
//         default: () => import('@/views/BooksView.vue'),
//         component: () => import('@/views/BookDetails.vue')
//       }
//     },
//     {
//       path: '/login',
//       name: 'login',
//       component: () => import('@/views/Login.vue')
//     },
//     {
//       path: '/signup',
//       name: 'signup',
//       component: () => import('@/views/Signup.vue')
//     }
//   ],
//   scrollBehavior(to, from, savedPosition) {
//     return { top: 0 }
//   }
// })

// export default router
