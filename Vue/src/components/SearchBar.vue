<template>
  <div class="relative w-full">
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
      <button
        role="button"
        aria-label="bouton de recherche"
        aria-roledescription="bouton pour lancer la recherche"
        class="inline mr-2"
        @click="search(text)"
      >
        <MagnifyingGlassIcon class="h-6 w-6" />
      </button>
    </label>
    <div
      v-if="panel"
      ref="panel"
      class="absolute mt-3 z-20 overflow-hidden overflow-y-auto bg-white max-w-5xl max-h-56 w-full p-4 shadow-md shadow-primary-dark/5 rounded-lg border-primary-light"
    >
      <div v-if="books.length" class="overflow-y-scroll grid gap-y-2 w-full">
        <div v-for="(book, index) in books" :key="index">
          <TwCard large :book="book" :to="`/books/${book?.id}`" />
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
import { TwCard } from '@/libs/ui/index.vue'
import { MagnifyingGlassIcon } from '@heroicons/vue/24/outline/index.js'
import { onClickOutside, onKeyStroke } from '@vueuse/core'

import type { Books } from '@/libs/interfaces/books'

const text = ref('')
const books = ref<Books[]>([])
const panel = ref(false)
const search = async (text: string) => {
  const { data } = await httpClient.get<Books[]>(`/books?search=${text}`)
  books.value = data
  computed(() => books.value)
  panel.value = true
  return data
}
onClickOutside(panel, () => (panel.value = false))
onKeyStroke('Escape', () => (panel.value = false))
</script>
