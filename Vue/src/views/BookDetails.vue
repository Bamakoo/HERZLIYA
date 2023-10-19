<template>
  <div v-if="!showLogin" class="max-w-lg lg:max-w-4xl mx-auto px-8">
    <div class="grid lg:grid-cols-2 gap-x-8 gap-y-8 lg:gap-y-0">
      <h1 class="lg:hidden text-5xl font-bold text-center">
        {{ book?.title ?? 'Titre du livre' }}
      </h1>

      <div class="aspect-square max-w-md bg-gray-300 rounded-md">
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
          <p>{{ book?.description }}</p>
        </div>
        <div class="flex-row-reverse lg:flex-row flex items-center lg:space-x-4">
          <!-- <TwButton size="m" @click="addToCart(book?.id, book)" class="ml-4 lg:ml-0 lg:w-1/2"
            ><ShoppingCartIcon class="w-5 h-5 lg:mr-2 text-white" /><span
              >Ajouter au panier</span
            ></TwButton
          > -->
          <TwButton
            v-if="book?.status !== 'available'"
            size="m"
            @click="buy(book?.id as string)"
            class="ml-4 lg:ml-0 lg:w-1/2 space-x-2"
            type="button"
            ><CreditCardIcon class="w-5 h-5 lg:mr-2 text-white" /><span>Acheter</span></TwButton
          >
          <TwLikes :on-submit="like" />
        </div>
        <TwButton
          v-if="book?.status !== 'available'"
          size="m"
          @click="cart"
          class="ml-4 lg:ml-0 lg:w-1/2 space-x-2"
          type="button"
          ><ShoppingCartIcon class="w-5 h-5 lg:mr-2 text-white" /><span
            >Ajouter au panier</span
          ></TwButton
        >
      </div>
    </div>
  </div>
  <RouterView v-if="!showLogin" />
  <Login v-if="showLogin" />
</template>

<script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { useRoute } from 'vue-router'

import { useBookStore } from '@/stores/useBookStore'
import { useCartStore } from '@/stores/useCartStore'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import { useFetchLikes } from '@/api/fetchs/useFetchLikes'
import httpClient from '@/api/httpClient'

import Login from './Login.vue'
import { TwButton, TwLikes } from '@/libs/ui/index.vue'
import { useAccountStore } from '@/stores/useAccountStore'
import { CreditCardIcon, ShoppingCartIcon } from '@heroicons/vue/24/outline'
import type { Books } from '@/libs/interfaces/books'

const accountStore = useAccountStore()

const route = useRoute()
const { id } = route.params
const bookStore = useBookStore()
const book = ref<Books>()

// const accountStore = useAccountStore()
const { addToCart, retrieve } = useFetchCart()
const cart = async (book: Books) => {
  try {
    const myCart = (await retrieve(accountStore.token)).books
    console.log('myCart before push :', myCart)
    myCart.push(book.id)
    console.log('hey')
    console.log('myCart :', typeof myCart)
    const data = await addToCart(accountStore.token as string, book.id)
    console.log('data', data)
    return data
  } catch (error) {
    throw new Error((error as Error).message)
  }
}

const cartStore = useCartStore()
const mycart = await cartStore.retrieveCart(accountStore.token)
console.log('mycart', mycart)
const showLogin = ref(false)

const buy = async (bookId: Books['id'], e?: SubmitEvent) => {
  e?.preventDefault()
  try {
    if (!accountStore.token) showLogin.value = true // Affiche la vue Login

    const data = await httpClient.post(`/books/${bookId}/purchase`, bookId, {
      headers: { Authorization: `Bearer ${accountStore.token}` }
    })
    // const data = (cart.purchased_at = new Date(Date.now()))
    return data
  } catch (error) {
    throw new Error((error as Error).message)
  }
}

const fetchLikes = useFetchLikes()
const liked = ref(false)
const like = () => {
  if (liked.value) {
    fetchLikes.create(book.value?.id as string)
    accountStore.token
    accountStore.userAccount?.likes?.push({
      userID: accountStore.token as string,
      bookID: book.value?.id,
      createdAt: Date.now()
    })
  }
  fetchLikes.del(book.value?.id as string)
  //POST DANS TABLE LIKES (USER -> LIKES) => USER TOKEN + BOOK ID
}

onBeforeMount(async () => (book.value = await bookStore.retrieveBook(id as string)))
</script>
