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
  // CurrencyEuroIcon,
  ShoppingBagIcon,
  PencilIcon,
  UsersIcon,
  TruckIcon
} from '@heroicons/vue/24/outline'
import { useAccountStore } from '@/stores/useAccountStore'
import LoginView from './views/LoginView.vue'
import router from './router'
import { useBookStore } from './stores/useBookStore'
import type { Books } from './libs/interfaces/books'
// import { fetchUsers } from './api/axios/users.routes'

const accountStore = useAccountStore()
onBeforeMount(async () => {
  books.value = await bookStore.books
  return accountStore.token
})
const bookStore = useBookStore()
const books = ref<Books[]>()

const filterGenre = () => {
  const { value } = accountMenu ?? genreMenu
  books.value?.filter((book) => book.genre === value)
  return books
}
const genreMenu = {
  value: 'genres',
  title: 'Genres',
  submenu: [
    {
      value: 'realism',
      icon: ShieldCheckIcon,
      name: 'Non-fiction',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    },
    {
      value: 'mystery',
      icon: MagnifyingGlassCircleIcon,
      name: 'Mystère',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    },
    {
      value: 'fantasy',
      icon: AcademicCapIcon,
      name: 'Fantaisie',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    },
    {
      value: 'romance',
      icon: HeartIcon,
      name: 'Romance',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    },
    {
      value: 'scienceFiction',
      icon: BeakerIcon,
      name: 'Science-Fiction',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    },
    {
      value: 'action',
      icon: RocketLaunchIcon,
      name: 'Action',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    },
    {
      value: 'horror',
      icon: BugAntIcon,
      name: 'Horreur',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    },
    {
      value: 'biography',
      icon: BuildingLibraryIcon,
      name: 'Biographie',
      attributes: {
        tag: 'button',
        onClick: filterGenre
      }
    }
  ]
}

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
        to: '/profile'
      }
    },
    {
      value: 'comments',
      icon: ChatBubbleOvalLeftIcon,
      name: 'Mes commentaires',
      attributes: {
        tag: 'RouterLink',
        to: '/comments'
      }
    },
    {
      value: 'orders',
      icon: ShoppingBagIcon,
      name: 'Mes commandes',
      attributes: {
        tag: 'RouterLink',
        to: '/orders'
      }
    },
    {
      value: 'sales',
      icon: TruckIcon,
      name: 'Mes ventes',
      attributes: {
        tag: 'RouterLink',
        to: '/sales'
      }
    },
    {
      value: 'favorite_books',
      icon: HeartIcon,
      name: 'Mes livres préférés',
      attributes: {
        tag: 'RouterLink',
        to: '/favorite_books'
      }
    },
    {
      value: 'favorite_author',
      icon: PencilIcon,
      name: 'Mon auteurice préféré.e',
      attributes: {
        tag: 'RouterLink',
        to: '/favorite_authors'
      }
    },
    {
      value: 'friends',
      icon: UsersIcon,
      name: 'Mes amis',
      attributes: {
        tag: 'RouterLink',
        to: '/friends'
      }
    }
  ]
}

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
      <aside
        v-if="accountStore.token || route.name === 'home' || route.name === 'book'"
        class="mr-4 flex items-start"
      >
        <TwSidebar
          :menu="route.path.startsWith('/account') ? accountMenu : genreMenu"
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
      </aside>
      <!-- </KeepAlive> -->
    </RouterView>
  </Suspense>
</template>
