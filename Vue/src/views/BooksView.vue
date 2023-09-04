<template>
  <div>
    <h1>Tous les livres</h1>
    <div class="gap-4 grid grid-cols-3">
      <div
        v-for="(book, index) in books"
        :key="index"
        class="bg-white rounded border max-w-md border-gray-300 cursor-pointer p-2"
        @click="goTo(book.id)"
      >
        <div class="flex justify-between">
          <div>
            <div class="text-lg font-semibold">{{ book.title }}</div>
            <div class="text-sm font-medium uppercase">{{ book.author }}</div>
          </div>
          <div class="text-right">
            <div>{{ book.state }}</div>
            <div class="font-semibold">{{ book.price }} €</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onBeforeMount, computed } from 'vue'
import { useBookStore } from '@/stores/useBookStore'
import router from '@/router'

const bookStore = useBookStore()
const books = await bookStore.books

// const states = 'horrendous'
//   ? 'Horrible'
//   : 'bad'
//   ? 'Mauvais'
//   : 'okay'
//   ? 'Okay'
//   : 'passable'
//   ? 'Passable'
//   : 'acceptable'
//   ? 'Acceptable'
//   : 'good'
//   ? 'Bon État'
//   : 'excellent'
//   ? 'Excellent'
//   : 'Neuf'

const goTo = (book_id: string) => router.push(`/books/${book_id}`)

onBeforeMount(() => computed(() => books))
</script>
