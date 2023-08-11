<script setup lang="ts">
import { ref } from 'vue'
// import router from './router/index.ts'
import { RouterView } from 'vue-router'
import TheHeader from './components/TheHeader.vue'
import TwSidebar from './libs/ui/TwSidebar.vue'
import {
  ShieldCheckIcon,
  MagnifyingGlassCircleIcon,
  AcademicCapIcon,
  HeartIcon,
  ChatBubbleOvalLeftIcon
} from '@heroicons/vue/24/outline'
// import { fetchUsers } from './api/axios/users.routes'

const menus = [
  { value: 'realism', icon: ShieldCheckIcon, name: 'Non-fiction', to: '#' },
  { value: 'mystery', icon: MagnifyingGlassCircleIcon, name: 'Mystère', to: '#' },
  { value: 'fantasy', icon: AcademicCapIcon, name: 'Fantaisie', to: '#' },
  { value: 'romance', icon: HeartIcon, name: 'Romance', to: '#' },
  { value: 'scienceFiction', icon: '', name: 'Science-Fiction', to: '#' },
  { value: 'action', icon: '', name: 'Action', to: '#' },
  { value: 'horror', icon: '', name: 'Horreur', to: '#' },
  { value: 'biography', icon: '', name: 'Biographie', to: '#' }
]

const accountMenu = [
  { value: 'profile', icon: ShieldCheckIcon, name: 'Mon Profile', to: '#' },
  { value: 'comments', icon: ChatBubbleOvalLeftIcon, name: 'Mes commentaires', to: '#' },
  { value: 'orders', icon: ShieldCheckIcon, name: 'Mes commandes', to: '#' },
  { value: 'sales', icon: ShieldCheckIcon, name: 'Mes ventes', to: '#' },
  { value: 'favorite_books', icon: HeartIcon, name: 'Mes livres préférés', to: '#' },
  { value: 'favorite_author', icon: ShieldCheckIcon, name: 'Mon Auteurice préféré.e', to: '#' },
  { value: 'friends', icon: ShieldCheckIcon, name: 'Mes amis', to: '#' }
]

// const { getUser } = await fetchUsers()
// const user = await getUser()

//router.push({ name: 'user', params: { user.id } })
const location = ref(window.location.pathname)
// window.addEventListener('hasChange', () => {

//   console.log(location.value)
// })

// console.log(location.value)
</script>

<template>
  <RouterView v-slot="{ Component }">
    <TheHeader />
    <Suspense>
      <component :is="Component" class="py-28 lg:py-32" />
    </Suspense>
    <TwSidebar :menu="location === '/account' ? accountMenu : menus" class="mt-32" />
  </RouterView>
</template>
