<script setup lang="ts">
import { onBeforeMount, ref } from 'vue'
import { RouterView, useRoute } from 'vue-router'
import Header from './components/Header.vue'
import TwSidebar from './libs/ui/TwSidebar.vue'
import {
  ShieldCheckIcon,
  MagnifyingGlassCircleIcon,
  AcademicCapIcon,
  HeartIcon,
  ChatBubbleOvalLeftIcon,
  BeakerIcon,
  RocketLaunchIcon,
  BugAntIcon,
  ArrowLeftIcon,
  BuildingLibraryIcon
} from '@heroicons/vue/24/outline'
import { useAccountStore } from '@/stores/useAccountStore'
import LoginView from './views/LoginView.vue'
import router from './router'
// import { fetchUsers } from './api/axios/users.routes'

const accountStore = useAccountStore()
onBeforeMount(() => {
  return accountStore.token
})
console.log(accountStore.token)
const menus = [
  { value: 'realism', icon: ShieldCheckIcon, name: 'Non-fiction', to: '/realism' },
  { value: 'mystery', icon: MagnifyingGlassCircleIcon, name: 'Mystère', to: '/mystery' },
  { value: 'fantasy', icon: AcademicCapIcon, name: 'Fantaisie', to: '/fantasy' },
  { value: 'romance', icon: HeartIcon, name: 'Romance', to: '/romance' },
  { value: 'scienceFiction', icon: BeakerIcon, name: 'Science-Fiction', to: '/science_fiction' },
  { value: 'action', icon: RocketLaunchIcon, name: 'Action', to: '/action' },
  { value: 'horror', icon: BugAntIcon, name: 'Horreur', to: '/horror' },
  { value: 'biography', icon: BuildingLibraryIcon, name: 'Biographie', to: '/biography' }
]

const accountMenu = [
  { value: 'profile', icon: ShieldCheckIcon, name: 'Mon Profile', to: '/profile' },
  { value: 'comments', icon: ChatBubbleOvalLeftIcon, name: 'Mes commentaires', to: '/comments' },
  { value: 'orders', icon: ShieldCheckIcon, name: 'Mes commandes', to: '#' },
  { value: 'sales', icon: ShieldCheckIcon, name: 'Mes ventes', to: '#' },
  { value: 'favorite_books', icon: HeartIcon, name: 'Mes livres préférés', to: '#' },
  { value: 'favorite_author', icon: ShieldCheckIcon, name: 'Mon Auteurice préféré.e', to: '#' },
  { value: 'friends', icon: ShieldCheckIcon, name: 'Mes amis', to: '#' }
]
const route = useRoute()
const routerArrow = router
const location = ref(route.path)
</script>

<template>
  <Header />
  <Suspense>
    <RouterView v-slot="{ Component }">
      <!-- <KeepAlive> -->
      <LoginView
        v-if="!accountStore.token && route.name !== 'home' && route.name !== 'book'"
        class="py-28 lg:py-32 px-8"
      />
      <component :is="Component" class="py-28 lg:py-32 px-8" />
      <!-- </KeepAlive> -->
    </RouterView>
  </Suspense>
  <aside class="mr-4 flex items-start">
    <TwSidebar :menu="location === '/account' ? accountMenu : menus" class="mt-32" />
    <button @click="routerArrow.back()" class="flex items-center space-x-2 sticky">
      <span class="sr-only">Retour</span>
      <ArrowLeftIcon
        class="relative top-[10%] ml-[5%] w-5 h-5 transition-colors duration-200 hover:text-primary"
        role="navigation"
        aria-label="Retour"
      />
      <span class="hidden lg:inline font-medium">Retour</span>
    </button>
  </aside>
</template>
