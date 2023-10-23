<template>
  <label
    class="focus-within:ring hidden md:visible md:flex items-center rounded-xl bg-primary-dark/30 min-w-full focus:ring-offset-0 focus:border-none px-2 text-gray-700"
  >
    <input
      v-model.trim="text"
      type="search"
      @input="filterBooks"
      dir="ltr"
      aria-autocomplete="list"
      aria-label="Tapez votre recherche"
      class="p-2 border-0 outline-0 bg-transparent placeholder:Rechercher placeholder:text-gray-900 w-full"
    />
    <button class="inline mr-2" @click="search(text)">
      <MagnifyingGlassIcon class="h-6 w-6" />
    </button>
  </label>
  <div v-if="text" class="absolute z-10 bg-white max-w-3xl p-4 space-y-2 overflow-y-scroll">
    <!-- <RouterLink :to="`/books/${book?.id}`"> -->
    <div
      v-for="(book, index) in filteredBooks"
      :key="index"
      class="flex justify-between border p-2 rounded-sm hover:bg-primary/20 hover:border-primary"
    >
      <div>
        <span class="block">{{ book.title }}</span>
        <span>{{ book.author }}</span>
      </div>
      <div class="text-right">
        <span class="block">{{ book.price }} €</span>
        <span>{{ book.state }}</span>
      </div>
    </div>
    <!-- </RouterLink> -->
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import httpClient from '@/api/httpClient'
import { MagnifyingGlassIcon } from '@heroicons/vue/24/outline/index.js'
import type { Books } from '@/libs/interfaces/books'

const text = ref('')
const books = ref<Books[]>([])

// const searchInput = document.querySelector('[data-search]')
// searchInput?.addEventListener('input', (e) => console.log(e.target?.value))
const search = async (text: string) => {
  console.log(text)
  const { data } = await httpClient.get<Books[]>('/books')
  console.log(data)
  books.value = data

  // return computed(() =>
  //   books.value.find(
  //     (e: Books) =>
  //       e.title?.toLowerCase().match(text.toLowerCase()) ||
  //       e.author?.toLowerCase().match(text.toLowerCase())
  //   )
  // )
  // const searchText = ref('')

  // const filteredBooks = computed(() => {
  //   const searchTerm = searchText.value.toLowerCase()
  //   if (searchTerm.trim() === '') {
  //     return books.value
  //   } else {
  //     return books.value.filter((book) => book.title?.toLowerCase().includes(searchTerm))
  //   }
  // })
}

const searchText = ref('')

const filteredBooks = computed(() => {
  const searchTerm = searchText.value.toLowerCase()
  if (searchTerm.trim() === '') {
    return books.value
  } else {
    return books.value.filter((book) => book.title?.toLowerCase().includes(searchTerm))
  }
})

const filterBooks = () => {
  // Appelée lors de la saisie dans la barre de recherche pour mettre à jour la liste filtrée.
}
</script>
