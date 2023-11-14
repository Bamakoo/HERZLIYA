<template>
  <div class="max-w-xl lg:max-w-4xl px-4 md:px-8 mx-auto">
    <h1 class="text-center text-4xl font-semibold mb-8">
      {{ selectedGenre ? `Catégorie ${selectedGenre}` : 'Tous les livres' }}
    </h1>
    <SearchBar class="lg:hidden" />
    <!-- <div v-if="selectedGenre" class="flex items-start mx-auto max-w-sm md:max-w-3xl">
      <div class="gap-4 mr-2 grid sm:grid-cols-2 w-11/12">
        <TwCard
          v-for="(book, index) in books"
          :key="index"
          :book="book"
          :to="`/books/${book.id}`"
          class="max-w-sm sm:max-w-none"
        />
      </div>
      <FilterBooks @change="selectGenre" />
    </div> -->
    <section class="flex items-start mx-auto max-w-sm md:max-w-3xl mt-8 lg:mt-0">
      <div class="gap-4 mr-2 grid lg:grid-cols-2 w-11/12">
        <TwCard
          v-for="(book, index) in books"
          :key="index"
          :book="book"
          :to="`/books/${book.id}`"
          class="max-w-sm sm:max-w-none"
        />
      </div>
      <FilterBooks :selected-genre="selectedGenre" @change="filter(selectedGenre)" />
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
// import { useBookStore } from '@/stores/useBookStore'
import { TwCard } from '@/libs/ui/index.vue'
import FilterBooks from '@/components/FilterBooks.vue'
import { useFetchBooks } from '@/api/fetchs/useFetchBooks'
import type { Books } from '@/libs/interfaces/books'
import SearchBar from '@/components/SearchBar.vue'

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

const fetchBooks = useFetchBooks()
const books = await fetchBooks.list()
onMounted(() => computed(() => books))

// const props = defineProps<{ searchResult: Books | Books[] }>()

const selectedGenre = ref<Books['genre']>(null)
const filter = (genre: Books['genre']) => {
  console.log('selectedGenre : ', selectedGenre.value)
  return computed(() => books.filter((book) => book.genre === (selectedGenre.value = genre)))
}
// bind selectedGenre à FilterGenre + le passer en arg
</script>
