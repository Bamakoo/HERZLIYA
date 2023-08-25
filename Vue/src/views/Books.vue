<template>
  <div class="p-8 mx-auto max-w-7xl">
    <div class="max-w-4 text-center text-lg">
      <h1>Vente ou troc : débarassez-vous de vos livres encombrants sur Herzliya !</h1>
    </div>
    <div>
      <h2 class="text-center py-8 text-5xl font-semibold">Livres {{ genre }}</h2>
      <!-- <span>Il y a {{ books.booksCount }} livres</span> -->
      <div class="max-w-4xl mx-auto space-y-8">
        <TwCard
          v-for="(book, index) in books"
          large
          :key="index"
          :title="book.title"
          :author="book.author"
          :price="book.price"
          :to="book.id"
          class="mx-auto"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue'
// import { mapActions } from 'pinia'

import TwCard from '@/libs/ui/TwCard.vue'
// import { getAllBooks } from '@/api/axios/books.api'
import { useBooksStore } from '@/stores/useBooksStore'
// import ImgTest from '../assets/books.jpg'
const genre = 'pathname'.split('/')

const booksStore = useBooksStore()
const allBooks = await booksStore.bookList
const books = computed(() => {
  return allBooks
  // return booksStore.getAllBooks
  // return JSON.parse(JSON.stringify(booksStore.getAllBooks)) //=> fonctionne j'ai bien un array vide
})
console.log('books : ', books.value)
console.log('allBooks', allBooks)

// const booksAction = () => {...mapActions('books', ['fetchBooks'])}

onMounted(() => {
  // const books = computed(() => booksStore.fetchBooks())
  // console.log(books.value)
  // return books
})
</script>
