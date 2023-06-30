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
      path: '/account',
      name: 'account',
      component: () => import('@/views/Account.vue')
    },
    {
      path: '/cart',
      name: 'cart',
      component: () => import('@/views/Kart.vue')
    },
    {
      path: '/book',
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
