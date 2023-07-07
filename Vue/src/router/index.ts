import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/views/Books.vue')
    },

    {
      path: '/add',
      name: 'addBook',
      // route level code-splitting
      // this generates a separate chunk (Add.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('@/views/AddBook.vue')
    },
    {
      path: '/account/:id',
      name: 'account-parent',
      component: () => import('@/views/Account.vue'),
      children: [
        {
          path: '/profile',
          component: () => import('@/components/User/UserProfile.vue'),
          name: 'profile'
        },
        {
          path: '/comments',
          component: () => import('@/components/User/UserComments.vue'),
          name: 'comments'
        },
        {
          path: '/likes',
          component: () => import('@/components/User/UserLikes.vue'),
          name: 'likes'
        },
        {
          path: '/sales',
          component: () => import('@/components/User/UserSales.vue'),
          name: 'sales'
        },
        {
          path: '/purchases',
          component: () => import('@/components/User/UserPurchases.vue'),
          name: 'purchases'
        },
        {
          path: '/favoriteauthor',
          component: () => import('@/components/User/UserFavoriteAuthor.vue'),
          name: 'favoriteauthor'
        },
        {
          path: '/friends',
          component: () => import('@/components/User/UserFriends.vue'),
          name: 'friends'
        }
      ]
    },
    {
      path: '/cart',
      name: 'cart',
      component: () => import('@/views/Kart.vue')
    },
    {
      path: '/book/**/*.vue',
      name: 'book',
      components: {
        default: () => import('@/layouts/BookLayout.vue'),
        component: () => import('@/views/BookDetails.vue')
      }
    }
  ],
  scrollBehavior(to, from, savedPosition) {
    return { top: 0 }
  }
})

export default router
