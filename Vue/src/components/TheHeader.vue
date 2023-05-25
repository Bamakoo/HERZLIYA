<template>
  <header class="w-full min-h-max fixed inset-0 bg-gray-500 flex p-2 justify-between align-middle">
    <div class="flex space-x-2">
      <div class="rounded-full aspect-square p-2 bg-gray-400">
        <img src="" alt="logo Herzliya" class="cover h-11 w-11" />
      </div>
      <input
        type="search"
        dir="ltr"
        aria-autocomplete="list"
        aria-label="Tapez votre recherche"
        class="rounded-3xl bg-gray-400 max-w-lg h-11 focus:ring focus:ring-gray-600 focus:ring-offset-0 focus:ring-offset-black p-3 text-gray-700"
      />
    </div>
    <nav class="grid grid-cols-4 gap-x-4 w-96">
      <RouterLink v-for="(nav, index) in navigation" :to="nav.to" :key="index">
        <component :is="nav.icon" class="h-7 w-7 text-gray-700" />
        <!-- On Hover apparait en dessous de l'icône
        <div
          :aria-describedby="nav.title"
          class="max-w-fit bg-gray-400 rounded-md text-gray-600 text-center p-2"
        >
          {{ nav.title }}
        </div>-->
      </RouterLink>
    </nav>
  </header>
</template>

<script setup lang="ts">
import {
  BookOpenIcon,
  PlusCircleIcon,
  UserCircleIcon,
  ShoppingCartIcon
} from '@heroicons/vue/24/outline/index.js'

const navigation = [
  { icon: BookOpenIcon, title: 'Livres', to: '../pages/books.vue' },
  { icon: PlusCircleIcon, title: 'Vendre mon livre', to: '../pages/addBook.vue' },
  { icon: UserCircleIcon, title: 'Mon Compte', to: '../pages/account.vue' },
  { icon: ShoppingCartIcon, title: 'Panier', to: '../pages/kart.vue' }
]
</script>
