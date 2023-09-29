<template>
  <div class="max-w-xl lg:max-w-4xl px-4 md:px-8 mx-auto">
    <h1 class="text-center text-4xl font-semibold mb-8">Tous les livres</h1>
    <div class="flex items-start mx-auto max-w-sm md:max-w-3xl">
      <div class="gap-4 mr-2 grid sm:grid-cols-2 w-11/12">
        <TwCard
          v-for="(book, index) in books"
          :key="index"
          :book="book"
          :to="`/books/${book.id}`"
          class="max-w-sm sm:max-w-none"
        />
      </div>
      <FilterBooks />
    </div>
  </div>
</template>

<script setup lang="ts">
import { onBeforeMount, computed, onMounted } from 'vue'
// import { useBookStore } from '@/stores/useBookStore'
import { TwCard } from '@/libs/ui/index.vue'
import FilterBooks from '@/components/FilterBooks.vue'
import { useFetchBooks } from '@/api/fetchs/useFetchBooks'

// const bookStore = useBookStore()
// const books = await bookStore.books

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

// const filterGenre = computed(() => books?.filter((book) => book.genre === value))
onMounted(() => computed(() => books))
const fetchBooks = useFetchBooks()
const books = await fetchBooks.list()
</script>
