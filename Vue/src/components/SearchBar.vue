<template>
  <div class="relative">
    <label
      class="focus-within:ring focus-within:ring-primary-dark flex items-center rounded-xl bg-primary-dark/30 min-w-full focus:ring-offset-0 focus:border-none px-2 text-gray-700"
    >
      <input
        v-model.trim="text"
        type="search"
        dir="ltr"
        aria-autocomplete="list"
        aria-label="Tapez votre recherche"
        class="p-2 border-0 outline-0 bg-transparent placeholder:italic placeholder:text-sm placeholder:text-gray-700 w-full"
        placeholder="Rechercher..."
      />
      <button class="inline mr-2" @click="search(text)">
        <MagnifyingGlassIcon class="h-6 w-6" />
      </button>
    </label>
    <div
      v-if="panel"
      ref="panel"
      class="absolute mt-3 z-20 bg-white max-w-3xl max-h-48 w-full p-4 shadow-md shadow-primary-dark/5 rounded-lg border-primary-light"
    >
      <div v-if="books.length" class="overflow-y-scroll grid gap-y-2">
        <div v-for="(book, index) in books" :key="index">
          <RouterLink
            :to="`/books/${book?.id}`"
            rel="noopener nofollow"
            class="flex justify-between border p-2 rounded-sm hover:bg-gray-100"
          >
            <div>
              <span class="block">{{ book.title }}</span>
              <span>{{ book.author }}</span>
            </div>
            <div class="text-right">
              <span class="block">{{ book.price }} €</span>
              <span>{{ book.state }}</span>
            </div>
          </RouterLink>
        </div>
      </div>
      <div v-else>
        <p>Ta recherche n'a pas abouti, sorry 🤷🏽</p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import httpClient from '@/api/httpClient'
import { MagnifyingGlassIcon } from '@heroicons/vue/24/outline/index.js'
import { onClickOutside, onKeyStroke } from '@vueuse/core'

import type { Books } from '@/libs/interfaces/books'

const text = ref('')
const books = ref<Books[]>([])
const panel = ref(false)
const search = async (text: string) => {
  const { data } = await httpClient.get<Books[]>(`http://localhost:8080/books?search=${text}`)
  console.log('search data', data)
  books.value = data
  computed(() => books.value)
  panel.value = true
  return data
}
onClickOutside(panel, () => (panel.value = false))
onKeyStroke('Escape', () => (panel.value = false))
onKeyStroke('Enter', () => search(text.value))
</script>
