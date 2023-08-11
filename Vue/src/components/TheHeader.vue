<template>
  <header
    class="fixed w-full max-h-max top-0 bg-primary flex px-2 pt-2 justify-between items-center align-middle"
  >
    <div class="flex space-x-2 px-2 items-center w-1/5">
      <RouterLink to="../">
        <div class="rounded-full aspect-square bg-gray-400">
          <img src="" alt="logo Herzliya" class="cover h-14 w-14" />
        </div>
      </RouterLink>
      <label
        class="focus-within:ring hidden md:visible md:flex items-center rounded-xl bg-primary-dark/30 min-w-full focus:ring-offset-0 focus:border-none px-2 text-gray-700"
      >
        <div class="inline mr-2"><MagnifyingGlassIcon class="h-6 w-6" /></div>
        <input
          type="search"
          dir="ltr"
          aria-autocomplete="list"
          aria-label="Tapez votre recherche"
          class="p-2 border-0 focus:ring-0 bg-transparent placeholder:Rechercher placeholder:text-gray-900 w-full"
        />
      </label>
    </div>
    <nav class="hidden lg:flex lg:justify-center lg:text-center mx-auto space-x-4">
      <RouterLink
        v-for="(nav, index) in navigation"
        :to="nav.to"
        :key="index"
        :active-class="'text-white border-b-2 border-b-white'"
        :aria-label="nav.title"
        class="h-full flex-col w-24 text-gray-700 transition-colors duration-200 hover:text-white hover:border-b-white"
      >
        <component :is="nav.icon" class="pb-1 h-12 w-12 mx-auto" />

        <span :aria-describedby="nav.title" class="text-center max-w-full">
          {{ nav.title }}
        </span>
      </RouterLink>
    </nav>
    <TwMenu :items="navigation" class="text-right lg:hidden relative" />
  </header>
</template>

<script setup lang="ts">
import TwMenu from './TwMenu.vue'
import {
  MagnifyingGlassIcon,
  HomeIcon,
  // BookOpenIcon,
  PlusCircleIcon,
  UserCircleIcon,
  ShoppingCartIcon
} from '@heroicons/vue/24/outline/index.js'

const navigation = [
  {
    icon: HomeIcon,
    title: 'Livres',
    to: '/'
  },
  { icon: PlusCircleIcon, title: 'Vendre', to: '/add' },
  { icon: UserCircleIcon, title: 'Compte', to: `/account` },
  { icon: ShoppingCartIcon, title: 'Panier', to: '/cart' }
]
</script>
