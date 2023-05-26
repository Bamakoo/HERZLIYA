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
      name: 'addBook',
      // route level code-splitting
      // this generates a separate chunk (Add.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AddBook.vue')
    },
    {
      path: '/account',
      name: 'account',
      component: () => import('../views/Account.vue')
    },
    {
      path: '/cart',
      name: 'cart',
      component: () => import('../views/Kart.vue')
    }
  ]
})

export default router
