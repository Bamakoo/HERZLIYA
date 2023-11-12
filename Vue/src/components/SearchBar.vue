<template>
  <label
    class="focus-within:ring focus-within:ring-primary-dark hidden md:visible md:flex items-center rounded-xl bg-primary-dark/30 min-w-full focus:ring-offset-0 focus:border-none px-2 text-gray-700"
  >
    <input
      v-model.trim="text"
      type="search"
      dir="ltr"
      aria-autocomplete="list"
      aria-label="Tapez votre recherche"
      class="p-2 border-0 outline-0 bg-transparent placeholder:Rechercher placeholder:text-gray-900 w-full"
    />
    <button class="inline mr-2" @click="search(text)">
      <MagnifyingGlassIcon class="h-6 w-6" />
    </button>
  </label>
  <div
    v-if="text"
    class="absolute -bottom-8 z-10 bg-white max-w-3xl w-full p-4 space-y-2 overflow-y-scroll grid lg:grid-cols-3 shadow-md shadow-primary-dark/5 rounded-lg border-primary-light"
  >
    <!-- <RouterLink :to="`/books/${book?.id}`"> -->
    <div
      v-for="(book, index) in search(text)"
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

const search = async (text: string) => {
  const searchRegex = new RegExp(
    '(?:[0-9a-zA-Z\\u00C0-\\u00FF\\s!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~]+)',
    'gi'
  )
  const matches = searchRegex.exec(text)
  const { data } = await httpClient.get<Books[]>('/books')
  books.value = data

  // computed(() => searchRegex.exec(text))

  // const filteredBooks = computed(() => {
  //   const res = books.value.filter(
  //     (book) => book.title?.match(searchRegex) || book.author?.match(searchRegex)
  //   )
  //   return res
  // })
  const filteredBooks = ref<Books[]>([])

  if (matches) {
    computed(
      () =>
        (filteredBooks.value = books.value.filter(
          (book) => book.title?.match(searchRegex) || book.author?.match(searchRegex)
        ))
    )
  }
  console.log(filteredBooks.value)
  return filteredBooks.value
}
</script>
