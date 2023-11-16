<template>
  <div class="max-w-7xl mx-auto relative">
    <div class="aspect-square max-w-xs mx-auto bg-gray-200 rounded-full mb-8">
      <!-- <img src="" alt="" class="object-contain object-left-top" /> -->
    </div>
    <div class="flex flex-col items-center space-y-2">
      <h1 class="text-3xl font-bold">{{ user.username }}</h1>
      <div class="space-x-2">
        <span>{{ user?.city }}, {{ user.country }}</span>
      </div>
      <div>
        <span class="font-medium">Membre depuis :</span> <span>{{ memberSince }}</span>
      </div>
      <div>
        <span class="font-medium">Livre préféré : </span> <span>{{ user.favoriteBook }}</span>
      </div>
      <div>
        <span class="font-medium">Auteurice préféré·e : </span>
        <span>{{ user.favoriteAuthor }}</span>
      </div>
    </div>

    <section class="my-20 px-4">
      <h2 class="text-center text-2xl font-semibold">Mes livres préférés 💖</h2>

      <div class="mx-auto grid gap-4 md:grid-cols-2 lg:grid-cols-3 mt-8">
        <div
          v-for="(book, index) in user?.likes"
          :key="index"
          class="rounded-lg p-3 bg-white border border-gray-200"
        >
          <RouterLink :to="`/books/${book.id}`" rel="noopener nofollow">
            <div v-if="book.title" class="text-center font-semibold leading-3 text-lg">
              {{ book.title }}
            </div>
          </RouterLink>
        </div>
      </div>
    </section>
    <section class="my-20 px-4">
      <h2 class="text-center text-2xl font-semibold">Mes achats 🛒</h2>

      <div class="mx-auto grid gap-4 md:grid-cols-2 lg:grid-cols-3 mt-8">
        <div
          v-for="(book, index) in user?.purchases"
          :key="index"
          class="rounded-lg p-3 bg-white border border-gray-200"
        >
          <div v-if="book.title" class="text-center font-semibold leading-6 text-lg">
            {{ book.title }}
          </div>
        </div>
      </div>
    </section>
    <TwButton color="red" class-name="absolute right-4" @click="logout">À la prochaine !</TwButton>
  </div>
</template>

<script setup lang="ts">
import { useAccountStore } from '@/stores/useAccountStore'
import { TwButton } from '@/libs/ui/index.vue'
import router from '@/router'
import axios from 'axios'

const accountStore = useAccountStore()

const user = await accountStore.fetchUserData()
console.log('user :', user)
const memberSince = new Date(user?.createdAt).toLocaleDateString('fr-FR')
const route = router

const logout = () => {
  axios.defaults.headers.delete.Authorization
  window.localStorage.removeItem('token')
  route.go(0)
}
</script>
