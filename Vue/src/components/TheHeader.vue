<template>
  <header
    class="relative w-full max-h-max top-0 bg-gray-500 flex p-2 justify-between items-center align-middle"
  >
    <div class="flex space-x-2 px-2 items-center w-1/5">
      <RouterLink to="../">
        <div class="rounded-full aspect-square bg-gray-400">
          <img src="" alt="logo Herzliya" class="cover h-14 w-14" />
        </div>
      </RouterLink>
      <label
        class="focus-within:ring hidden md:visible md:flex items-center rounded-xl bg-gray-400 min-w-full focus:ring-offset-0 focus:border-none px-2 text-gray-700"
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
    <nav class="hidden lg:flex lg:justify-center mx-auto space-x-4">
      <RouterLink
        v-for="(nav, index) in navigation"
        :to="nav.to"
        :key="index"
        :active-class="'text-gray-900 border-b-2 border-b-gray-900'"
        class="h-full w-24 text-gray-700 hover:bg-gray-700/25"
      >
        <component :is="nav.icon" class="p-1 h-12 w-12 mx-auto" />
        <!-- On Hover apparait en dessous de l'icône -->
        <!-- <span
          :aria-describedby="nav.title"
          class="absolute max-w-fit bg-gray-400 rounded-md text-gray-600 text-center p-2"
        >
          {{ nav.title }}
        </span> -->
      </RouterLink>
    </nav>
    <TwMenu :items="navigation" class="text-right lg:hidden relative" />
  </header>
</template>

<script setup lang="ts">
import { ref } from 'vue'
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
    icon: HomeIcon, //ou HomeIcon pour faire comprendre qu'on est à l'accueil
    title: 'Livres',
    to: '/'
  },
  { icon: PlusCircleIcon, title: 'Vendre mon livre', to: '/add' },
  { icon: UserCircleIcon, title: 'Mon Compte', to: '/account' },
  { icon: ShoppingCartIcon, title: 'Panier', to: '/cart' }
]

const visible = ref(false)
</script>
<style scoped>
a:hover + span {
  display: block;
  color: #4287f5;
  font-size: 20px;
}
</style>
