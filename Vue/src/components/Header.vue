<template>
  <div class="w-full min-h-max fixed inset-0 bg-gray-500">
    <div>
      <div class="rounded-full max-w-md max-h-full bg-gray-400">Logo</div>
      <input
        type="search"
        dir="ltr"
        aria-autocomplete="list"
        class="rounded-xl bg-gray-400 max-w-md min-w-max min-h-max focus:ring focus:ring-gray-600"
        aria-label="Tapez votre recherche"
      />
    </div>
    <div class="grid grid-cols-4">
      <RouterLink v-for="(nav, index) in navigation" :to="nav.to" :key="index">
        {{ nav.title }}
      </RouterLink>
    </div>
  </div>
</template>

<script setup lang="ts">
import { UserCircleIcon } from '@heroicons/vue/24/outline/index.js'
const navigation = [
  {
    icon: '',
    title: 'Livre',
    value: 'books',
    to: '../pages/books.vue'
  },
  { icon: '', title: 'Vendre mon livre', value: 'addBook', to: '../pages/addBook.vue' },
  { icon: UserCircleIcon, title: 'Mon Compte', value: 'account', to: '../pages/account.vue' },
  { icon: '', title: 'Panier', value: 'kart', to: '../pages/kart.vue' }
]
</script>
