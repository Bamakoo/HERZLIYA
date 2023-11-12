<template>
  <div class="max-w-7xl mx-auto p-8 space-y-28">
    <div class="flex flex-col items-center space-y-4">
      <!-- <div class="aspect-w-1 aspect-h-1 rounded-full">
        <img :src="user.img" :alt="user.username" class="object-cover object-top" />
      </div> -->
      <h1 class="text-3xl font-bold mb-6">{{ user.username }}</h1>
      <div class="space-x-2">
        <span>{{ user?.city }}, {{ user.country }}</span>
      </div>
      <div>
        <span>Membre depuis : {{ memberSince }}</span>
      </div>
      <div>
        <span>Livre préféré : {{ user.favoriteBook }}</span>
      </div>
      <div>
        <span>Auteur préféré : {{ user.favoriteAuthor }}</span>
      </div>
    </div>
    <div class="grid gap-y-4 lg:grid-cols-3 lg:gap-4 mt-8">
      <div
        v-for="(book, index) in user?.books"
        :key="index"
        class="rounded max-w-lg bg-white border border-gray-300"
      >
        <div>
          <span class="block">{{ book.title }}</span>
          <span class="block uppercase">{{ book.author }}</span>
        </div>
        <div>
          <span class="block">{{ book.state }}</span>
          <span class="block">{{ book.price }}</span>
        </div>
      </div>
    </div>
    <TwButton color="red" class="mx-auto" @click="logout">Bye Bye</TwButton>
  </div>
</template>

<script setup lang="ts">
import { useAccountStore } from '@/stores/useAccountStore'
import { TwButton } from '@/libs/ui/index.vue'
import router from '@/router'
import axios from 'axios'

const accountStore = useAccountStore()
// const user = await accountStore.account
const user = accountStore.account
console.log('user :', user)
const memberSince = user?.createdAt?.toLocaleString('fr-FR')

const route = router

const logout = () => {
  axios.defaults.headers.delete.Authorization
  window.localStorage.removeItem('token')
  route.go(0)
}
</script>
