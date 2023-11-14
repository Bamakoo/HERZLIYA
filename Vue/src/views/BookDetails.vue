<template>
  <div v-if="!showLogin" class="max-w-lg lg:max-w-4xl mx-auto px-8">
    <div class="grid lg:grid-cols-2 gap-x-8 gap-y-8 lg:gap-y-0">
      <h1 class="lg:hidden text-5xl font-bold text-center">
        {{ book?.title ?? 'Titre du livre' }}
      </h1>

      <div class="aspect-square max-w-md bg-gray-200 rounded-md">
        <img src="" alt="" />
      </div>
      <div class="space-y-8">
        <div class="flex items-center justify-between lg:block">
          <div>
            <h1 class="hidden lg:block text-5xl font-bold">
              {{ book?.title ?? 'Titre du livre' }}
            </h1>
            <h2 class="text-xl font-medium uppercase">{{ book?.author }}</h2>
          </div>
          <div class="text-right lg:text-left">
            <div class="font-medium">Prix : {{ `${book?.price} €` }}</div>
            <div class="font-medium">État : {{ book?.state }}</div>
          </div>
        </div>

        <div class="flex-row-reverse lg:flex-row flex items-center lg:space-x-4">
          <TwButton size="m" @click="buy" class="ml-4 lg:ml-0 lg:w-1/2 space-x-2" type="button"
            ><CreditCardIcon class="w-5 h-5 mr-2 text-white" /><span>Acheter</span></TwButton
          >
          <TwLikes :book-id="id" />
        </div>
        <TwButton
          type="button"
          size="m"
          class="lg:w-1/2 space-x-2"
          color="border border-secondary hover:bg-secondary text-secondary hover:text-white"
          @click="addCart"
          ><ShoppingCartIcon class="w-5 h-5 mr-2" /><span>Ajouter au panier</span></TwButton
        >
        <div
          class="bg-red-600/80 border-red-500 text-white p-4 border rounded-md max-w-fit mx-auto mt-8"
        >
          <p>
            Attention : si tu retires ce livre de ton panier tu ne pourras plus le remettre dedans !
          </p>
        </div>

        <div
          v-if="added"
          class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative"
          role="alert"
        >
          <strong class="font-bold">Ajouté</strong>
          <span class="block sm:inline">Ton livre a bien été ajouté à ton panier !</span>
          <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
            <button type="button" @click="() => (added = false)">
              <XMarkIcon class="h-6 w-6 text-green-600" />
            </button>
          </span>
        </div>
      </div>
    </div>
  </div>
  <!-- <UserComments :book-id="id" /> -->
  <RouterView v-if="!showLogin" />
  <Login v-if="showLogin" />
</template>

<script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { useRoute } from 'vue-router'

import httpClient from '@/api/httpClient'

import Login from './Login.vue'
import { TwButton, TwLikes } from '@/libs/ui/index.vue'
import { useAccountStore } from '@/stores/useAccountStore'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import { CreditCardIcon, ShoppingCartIcon, XMarkIcon } from '@heroicons/vue/24/outline'
import type { Books } from '@/libs/interfaces/books'
import { useFetchBooks } from '@/api/fetchs/useFetchBooks'

const accountStore = useAccountStore()

const route = useRoute()
const { id } = route.params
const { addToCart } = useFetchCart()
const { retrieve } = useFetchBooks()
const book = ref<Books>()
const added = ref(false)
const showLogin = ref(false)

onBeforeMount(async () => (book.value = await retrieve(id as string)))

const addCart = async () => {
  try {
    if (!accountStore.token) showLogin.value = true
    const data = await addToCart(id as string)
    console.log('data', data)
    added.value = true
  } catch (error) {
    throw new Error((error as Error).message)
  }
}

const buy = async () => {
  try {
    if (!accountStore.token) {
      showLogin.value = true
      return
    }

    const { data } = await httpClient.patch(`/books/${id}/purchase`, id, {
      headers: { Authorization: `Bearer ${accountStore.token}` }
    })
    return data
  } catch (error) {
    throw new Error((error as Error).message)
  }
}
</script>
