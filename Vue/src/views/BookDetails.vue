<template>
  <div class="max-w-7xl grid grid-cols-2">
    <div class="aspect-square max-w-md bg-gray-300 rounded-md">
      <img src="" alt="" />
    </div>
    <div>
      <h1 class="text-5xl font-bold">{{ book?.title ?? 'Titre du livre' }}</h1>
      <h2 class="text-xl font-medium uppercase">{{ book?.author }}</h2>
      <div>
        <div class="font-medium">Prix : {{ `${book?.price} €` }}</div>
        <div class="font-medium">État : {{ book?.state }}</div>
      </div>

      <TwButton @click="addToCart(book?.id ?? '')">Ajouter au panier</TwButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { useRoute } from 'vue-router'
import { useBookStore } from '@/stores/useBookStore'
import { useFetchCart } from '@/api/fetchs/useFetchCart'
import { TwButton } from '@/libs/ui/index.vue'
import type { Books } from '@/libs/interfaces/books'

const route = useRoute()
const { id } = route.params
const bookStore = useBookStore()
const book = ref<Books>()
const fetchCart = useFetchCart()
const addToCart = async (book_id: Books['id']) => {
  // const data = await fetchCart.create()
  // data.books.push(book_id)
}

onBeforeMount(async () => (book.value = await bookStore.retrieveBook(id as string)))
</script>
