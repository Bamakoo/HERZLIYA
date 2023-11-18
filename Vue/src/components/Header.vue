<template>
  <header
    class="fixed w-full z-10 max-h-max top-0 bg-primary flex px-2 pt-2 justify-between items-center align-middle"
  >
    <div class="relative flex space-x-2 px-2 items-center w-1/3">
      <div class="aspect-square">
        <RouterLink to="/" rel="noopener nofollow">
          <img :src="logo" alt="logo Herzliya" class="object-contain h-14 w-14 shrink-0" />
        </RouterLink>
      </div>

      <SearchBar class="hidden lg:inline" />
    </div>
    <nav class="hidden lg:relative lg:flex lg:justify-center lg:text-center mx-auto space-x-4">
      <RouterLink
        v-for="(nav, index) in navigation"
        :key="index"
        :to="nav.to"
        rel="noopener nofollow"
        :active-class="'text-white border-b-2 border-b-white'"
        :aria-label="nav.title"
        class="h-full flex-col w-24 text-gray-700 transition-colors duration-200 hover:text-white hover:border-b-white"
      >
        <!-- <div v-if="nav.value === 'cart' && cartStore" class="t-0 absolute right-3">
          <p
            class="flex h-2 w-2 items-center justify-center rounded-full bg-red-500 p-3 text-xs text-white"
          >
            {{ cartStore.length }}
          </p>
        </div> -->
        <component :is="nav.icon" class="pb-1 h-12 w-12 mx-auto" />

        <span :aria-describedby="nav.title" class="text-center max-w-full">
          {{ nav.title }}
        </span>
      </RouterLink>
    </nav>
    <Menu :items="navigation" class="text-right lg:hidden relative" />
  </header>
</template>

<script setup lang="ts">
import Menu from './Menu.vue'
import logo from '@/assets/logo.png'
import {
  HomeIcon,
  PlusCircleIcon,
  UserCircleIcon,
  ShoppingCartIcon
} from '@heroicons/vue/24/outline/index.js'
import SearchBar from './SearchBar.vue'
import { useCartStore } from '@/stores/useCartStore'

const navigation = [
  {
    value: 'home',
    icon: HomeIcon,
    title: 'Livres',
    to: '/'
  },
  { value: 'sell', icon: PlusCircleIcon, title: 'Vendre', to: '/add' },
  { value: 'account', icon: UserCircleIcon, title: 'Compte', to: `/account` },
  { value: 'cart', icon: ShoppingCartIcon, title: 'Panier', to: '/cart' }
]

const cartStore = useCartStore().cart
</script>
