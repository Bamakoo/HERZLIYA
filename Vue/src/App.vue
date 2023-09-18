<script setup lang="ts">
import { onBeforeMount, ref } from 'vue'
import { RouterView, useRoute } from 'vue-router'
import Header from './components/Header.vue'
import { TwSidebar, TwButton } from './libs/ui/index.vue'
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
  BuildingLibraryIcon,
  UserCircleIcon,
  CurrencyEuroIcon,
  ShoppingBagIcon,
  PencilIcon,
  UsersIcon,
  TruckIcon
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
  { value: 'realism', icon: ShieldCheckIcon, name: 'Non-fiction', genre: 'realism' },
  { value: 'mystery', icon: MagnifyingGlassCircleIcon, name: 'Mystère', genre: 'mystery' },
  { value: 'fantasy', icon: AcademicCapIcon, name: 'Fantaisie', genre: 'fantasy' },
  { value: 'romance', icon: HeartIcon, name: 'Romance', genre: 'romance' },
  { value: 'scienceFiction', icon: BeakerIcon, name: 'Science-Fiction', genre: 'science_fiction' },
  { value: 'action', icon: RocketLaunchIcon, name: 'Action', genre: 'action' },
  { value: 'horror', icon: BugAntIcon, name: 'Horreur', genre: 'horror' },
  { value: 'biography', icon: BuildingLibraryIcon, name: 'Biographie', genre: 'biography' }
]

const accountMenu = [
  { value: 'profile', icon: UserCircleIcon, name: 'Mon Profile', to: '/profile' },
  { value: 'comments', icon: ChatBubbleOvalLeftIcon, name: 'Mes commentaires', to: '/comments' },
  { value: 'orders', icon: ShoppingBagIcon, name: 'Mes commandes', to: '/orders' },
  { value: 'sales', icon: TruckIcon, name: 'Mes ventes', to: '/sales' },
  { value: 'favorite_books', icon: HeartIcon, name: 'Mes livres préférés', to: '/favorite_books' },
  {
    value: 'favorite_author',
    icon: PencilIcon,
    name: 'Mon auteurice préféré.e',
    to: '/favorite_authors'
  },
  { value: 'friends', icon: UsersIcon, name: 'Mes amis', to: '/friends' }
]
const route = useRoute()
const routerArrow = router
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
      <component v-else :is="Component" class="py-28 lg:py-32 mx-auto" />
      <!-- </KeepAlive> -->
    </RouterView>
  </Suspense>
  <!-- <aside
    v-if="accountStore.token || route.name === 'home' || route.name === 'book'"
    class="mr-4 flex items-start"
  >
    <TwSidebar
      :menu="route.path === '/account' ? accountMenu : menus"
      class="mt-32 mr-2 hidden lg:flex"
    />
    <TwButton
      @click="routerArrow.back()"
      size="s"
      role="button"
      aria-roledescription="Retour"
      class="relative top-32 text-gray-700 bg-transparent hover:bg-transparent transition-colors duration-150 hover:text-primary whitespace-nowrap"
    >
      <span class="sr-only">Retour</span>
      <ArrowLeftIcon class="w-5 h-5 inline mr-2" role="navigation" aria-label="Retour" />
      <span class="text-base hidden lg:inline font-medium">Retour</span>
    </TwButton>
  </aside> -->
</template>
