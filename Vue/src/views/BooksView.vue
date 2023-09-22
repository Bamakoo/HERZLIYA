<template>
  <div class="max-w-xl lg:max-w-4xl px-4 md:px-8 mx-auto">
    <h1 class="text-center text-4xl font-semibold mb-8">Tous les livres</h1>
    <FilterBooks />
    <div class="gap-4 mx-auto max-w-sm md:max-w-3xl grid sm:grid-cols-2">
      <!-- <div
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
      </div> -->
      <TwCard
        v-for="(book, index) in books"
        :key="index"
        :book="book"
        :to="`/books/${book.id}`"
        class="max-w-sm sm:max-w-none"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { onBeforeMount, computed } from 'vue'
import { useBookStore } from '@/stores/useBookStore'
import router from '@/router'
import { TwCard } from '@/libs/ui/index.vue'
import FilterBooks from '@/components/FilterBooks.vue'

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
