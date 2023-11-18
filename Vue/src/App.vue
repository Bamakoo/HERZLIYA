<script setup lang="ts">
import { ref } from 'vue'
import { RouterView, useRoute } from 'vue-router'
import Header from './components/Header.vue'
import { TwSidebar } from './libs/ui/index.vue'
import {
  HeartIcon,
  ChatBubbleOvalLeftIcon,
  ArrowLeftIcon,
  UserCircleIcon,
  ShoppingBagIcon,
  PencilIcon,
  UsersIcon,
  TruckIcon
} from '@heroicons/vue/24/outline'
import { useAccountStore } from '@/stores/useAccountStore'
import Login from './views/Login.vue'
import router from './router'

const accountStore = useAccountStore()

const token = ref(localStorage.getItem('token'))

const accountMenu = {
  value: 'account',
  title: 'Mon compte',
  submenu: [
    {
      value: 'profile',
      icon: UserCircleIcon,
      name: 'Mon Profile',
      attributes: {
        tag: 'RouterLink',
        to: '/account/profile'
      }
    },
    {
      value: 'comments',
      icon: ChatBubbleOvalLeftIcon,
      name: 'Mes commentaires',
      attributes: {
        tag: 'RouterLink',
        to: '/account/comments'
      }
    },
    {
      value: 'orders',
      icon: ShoppingBagIcon,
      name: 'Mes commandes',
      attributes: {
        tag: 'RouterLink',
        to: '/account/orders'
      }
    },
    {
      value: 'sales',
      icon: TruckIcon,
      name: 'Mes ventes',
      attributes: {
        tag: 'RouterLink',
        to: '/account/sales'
      }
    },
    {
      value: 'favorite_books',
      icon: HeartIcon,
      name: 'Mes livres préférés',
      attributes: {
        tag: 'RouterLink',
        to: '/account/favorite_books'
      }
    },
    {
      value: 'favorite_author',
      icon: PencilIcon,
      name: 'Mon auteurice préféré.e',
      attributes: {
        tag: 'RouterLink',
        to: '/account/favorite_authors'
      }
    },
    {
      value: 'friends',
      icon: UsersIcon,
      name: 'Mes amis',
      attributes: {
        tag: 'RouterLink',
        to: '/account/friends'
      }
    }
  ]
}

const route = useRoute()
</script>

<template>
  <Header />
  <Suspense>
    <RouterView v-slot="{ Component }">
      <main class="py-28 lg:py-32 mx-auto">
        <!-- <KeepAlive> -->
        <Login
          v-if="
            !accountStore.token &&
            !token &&
            route.path !== '/' &&
            route.name !== 'book' &&
            route.path !== '/signup'
          "
        />
        <!-- && route.path !== '/account' -->

        <button
          role="button"
          aria-roledescription="Retour"
          class="ml-4 sm:px-2.5 sm:py-1.5 sm:text-xs sm:font-medium sm:leading-6 top-10 transition-colors duration-150 whitespace-nowrap flex items-center lg:hover:text-primary"
          @click="router.back()"
        >
          <span class="sr-only">Retour</span>
          <ArrowLeftIcon class="w-5 h-5 inline mr-2" role="navigation" aria-label="Retour" />
          <span class="text-base inline font-medium">Retour</span>
        </button>
        <component :is="Component" />
      </main>

      <!-- </KeepAlive> -->
    </RouterView>
  </Suspense>
</template>
