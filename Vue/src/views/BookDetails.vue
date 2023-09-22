<template>
  <div class="max-w-lg lg:max-w-4xl mx-auto px-8">
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
          <TwButton size="m" @click="addToCart(book?.id, book)" class="ml-4 lg:ml-0 lg:w-1/2"
            ><ShoppingCartIcon class="w-5 h-5 lg:mr-2 text-white" /><span
              >Ajouter au panier</span
            ></TwButton
          >
          <TwLikes />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { useRoute } from 'vue-router'
import { useBookStore } from '@/stores/useBookStore'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import { TwButton, TwLikes } from '@/libs/ui/index.vue'
import type { Books } from '@/libs/interfaces/books'
// import { useAccountStore } from '@/stores/useAccountStore'
import { ShoppingCartIcon } from '@heroicons/vue/24/outline'

const route = useRoute()
const { id } = route.params
const bookStore = useBookStore()
const book = ref<Books>()
// const fetchCart = useFetchCart()
// const accountStore = useAccountStore()
const { addToCart } = useFetchCart()
// const addToCart = async (book: Books) => {
//   const data = accountStore.userAccount?.cart?.books
//   console.log(data)

//   fetchCart.create([data as Books])
//   data?.push(book)
//   console.log(data)
//   return data
// }

onBeforeMount(async () => (book.value = await bookStore.retrieveBook(id as string)))
</script>
