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
          <TwLikes :book-id="id" />
        </div>
        <TwButton
          v-if="book?.status !== 'available'"
          type="button"
          size="m"
          class="ml-4 lg:ml-0 lg:w-1/2 space-x-2"
          color="bg-gray-50 border-secondary border hover:bg-secondary text-secondary-dark hover:text-white"
          :disabled="isAlreadyInCart"
          @click="addCart"
          ><ShoppingCartIcon class="w-5 h-5 lg:mr-2" /><span>Ajouter au panier</span></TwButton
        >

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
  <RouterView v-if="!showLogin" />
  <Login v-if="showLogin" />
</template>

<script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { useRoute } from 'vue-router'

import { useBookStore } from '@/stores/useBookStore'
// import { useCartStore } from '@/stores/useCartStore'
// import { useFetchCart } from '@/api/fetchs/useFetchCart'
// import { useFetchLikes } from '@/api/fetchs/useFetchLikes'
import httpClient from '@/api/httpClient'

import Login from './Login.vue'
import { TwButton, TwLikes } from '@/libs/ui/index.vue'
import { useAccountStore } from '@/stores/useAccountStore'
import { CreditCardIcon, ShoppingCartIcon, XMarkIcon } from '@heroicons/vue/24/outline'
import type { Books } from '@/libs/interfaces/books'

const accountStore = useAccountStore()

const route = useRoute()
const { id } = route.params
const bookStore = useBookStore()
const book = ref<Books>()
const isAlreadyInCart = ref(false)
const added = ref(false)
// const accountStore = useAccountStore()

const addCart = async () => {
  try {
    console.log('cart button pushed')
    // if (!accountStore.token) showLogin.value = true // Affiche la vue Login

    const data = await httpClient.post<Books>(`/books/${id}/add-to-kart`, id, {
      headers: { Authorization: `Bearer b5ZvjMmJQNbgzcCahIm6uA==` }
    })
    console.log('data', data)
    added.value = true
    isAlreadyInCart.value = true
  } catch (error) {
    throw new Error((error as Error).message)
  }
}

console.log(id)
// const cartStore = useCartStore()
// const mycart = await cartStore.retrieveCart(accountStore.token)
// console.log('mycart', mycart)
const showLogin = ref(false)

const buy = async (bookId: Books['id']) => {
  try {
    console.log('token from book details : ', accountStore.token)
    if (!accountStore.token) {
      showLogin.value = true
      return
    } // Affiche la vue Login

    const data = await httpClient.patch(`/books/${bookId}/purchase`, bookId, {
      headers: { Authorization: `Bearer b5ZvjMmJQNbgzcCahIm6uA==` }
    })
    // const data = (cart.purchased_at = new Date(Date.now()))
    return data
  } catch (error) {
    throw new Error((error as Error).message)
  }
}

// const fetchLikes = useFetchLikes()
// const liked = ref(false)
// const like = async () => {
//   //   if (liked.value) {
//   //  //fetchLikes.create(book.value?.id as string)
//   //     // ;('b5ZvjMmJQNbgzcCahIm6uA==')
//   //     // accountStore.userAccount?.likes?.push({
//   //     //   userID: 'b5ZvjMmJQNbgzcCahIm6uA==',
//   //     //   bookID: book.value?.id,
//   //     //   createdAt: Date.now()
//   //     // })
//   //   }
//   const data = await httpClient.post<Likes>(
//     `/likes/${id}`,
//     { data: null },
//     {
//       headers: {
//         Authorization: `Bearer b5ZvjMmJQNbgzcCahIm6uA==`
//       }
//     }
//   ) //fetchLikes.create(book.value?.id as string)
//   // fetchLikes.del(book.value?.id as string)
//   return data
//   //POST DANS TABLE LIKES (USER -> LIKES) => USER TOKEN + BOOK ID
// }

onBeforeMount(async () => (book.value = await bookStore.retrieveBook(id as string)))
</script>
