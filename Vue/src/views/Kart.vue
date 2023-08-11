<template>
  <div class="p-8 mx-auto max-w-7xl">
    <div class="max-w-4 text-center text-lg">
      <h1>Mon panier</h1>
    </div>
    <div>
      <h2 class="text-center py-8 text-5xl font-semibold">
        Tu as {{ books.booksCount }} dans ton panier
      </h2>
      <span>Il y a {{ books.booksCount }} livres</span>
      <div class="max-w-4xl mx-auto space-y-8">
        <TwCard
          v-for="(book, index) in books.favs"
          large
          :key="index"
          :title="book.title"
          :img="book.img"
          :author="book.author"
          :price="book.price"
          :to="book.id"
          :seller="book.seller"
          class="mx-auto"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useBooksStore } from '@/stores/useBooksStore'
import TwCard from '@/libs/ui/TwCard.vue'
const books = useBooksStore()
</script>
