<template>
  <div class="max-w-xl lg:max-w-7xl px-4 md:px-8 mx-auto">
    <h1 class="text-center text-4xl font-semibold mt-8 lg:mt-0 mb-8">
      {{ selectedGenre ? `Catégorie ${selectedGenre}` : 'Tous les livres' }}
    </h1>
    <SearchBar class="lg:hidden" />

    <section class="mx-auto max-w-sm md:max-w-3xl mt-8 lg:mt-0">
      <div class="gap-4 grid lg:grid-cols-2">
        <TwCard
          v-for="(book, index) in books"
          :key="index"
          :book="book"
          :to="`/books/${book.id}`"
          large
          class="max-w-sm sm:max-w-none"
        />
      </div>
      <!-- <FilterBooks :selected-genre="selectedGenre" @change="filter(selectedGenre)" /> -->
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useFetchBooks } from '@/api/fetchs/useFetchBooks'
import { TwCard } from '@/libs/ui/index.vue'
// import FilterBooks from '@/components/FilterBooks.vue'
import SearchBar from '@/components/SearchBar.vue'
import type { Books } from '@/libs/interfaces/books'

const { list } = useFetchBooks()
const books = ref<Books[]>()

onMounted(async () => (books.value = await list()))

const selectedGenre = ref<Books['genre']>(null)
// const filter = (genre: Books['genre']) =>
//   computed(() => books.value?.filter((book) => book.genre === genre))
</script>
