<script setup lang="ts">
import { ref } from 'vue'
import { RouterLink, RouterView, useRoute } from 'vue-router'
import Header from './components/Header.vue'
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
const route = useRoute()
const { id } = route.params
const location = ref(window.location.pathname)
</script>

<!-- <template>
  <header>
    <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="125" height="125" />

    <nav class="flex justify-start flex-wrap">
      <RouterLink to="/">Home</RouterLink>
      <RouterLink to="/add">Vendre un livre</RouterLink>
      <RouterLink to="/account">Compte</RouterLink>
      <RouterLink to="/cart">Panier</RouterLink>
    </nav>
  </header>
  <Suspense>
    <RouterView />
  </Suspense>
  <TwSidebar/>

  
</template> -->
<template>
  <Header />
  <RouterView v-slot="{ Component }">
    <Suspense>
      <component :is="Component" class="py-28 lg:py-32" />
    </Suspense>
    <aside class="mr-4">
      <TwSidebar :menu="location === '/account' ? accountMenu : menus" class="mt-32" />
    </aside>
  </RouterView>
</template>

<!-- <style scoped>
header {
  line-height: 1.5;
  max-height: 100vh;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

nav {
  width: 100%;
  font-size: 12px;
  text-align: center;
  margin-top: 2rem;
}

nav a.router-link-exact-active {
  color: var(--color-text);
}

nav a.router-link-exact-active:hover {
  background-color: transparent;
}

nav a {
  display: inline-block;
  padding: 0 1rem;
  border-left: 1px solid var(--color-border);
}

nav a:first-of-type {
  border: 0;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  nav {
    text-align: left;
    margin-left: -1rem;
    font-size: 1rem;

    padding: 1rem 0;
    margin-top: 1rem;
  }
}
</style> -->
