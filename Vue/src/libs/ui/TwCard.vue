<template>
  <div
    v-if="large"
    class="flex rounded-md overflow-hidden bg-white max-w-2xl h-28 border border-gray-200"
  >
    <!-- <div class="aspect-square w-1/3">
    <RouterLink :to="to" rel="noopener">
     <img :src="book.img" :alt="`${book.title}`" class="object-cover object-top shrink-0" />
    </RouterLink>
     </div> -->
    <div class="p-2 w-full">
      <RouterLink :to="to" rel="noopener"
        ><span class="text-lg font-bold block">{{ book.title }}</span></RouterLink
      >
      <div class="flex justify-between">
        <span class="text-sm">{{ book.author }}</span>
        <span class="text-base font-bold">{{ book.price ? `${book.price} €` : 'Gratuit' }}</span>
      </div>
    </div>
  </div>

  <div v-else class="bg rounded-lg max-w-sm p-3 bg-white border border-gray-200">
    <div class="aspect-w-3 rounded-md overflow-hidden aspect-h-1 w-full">
      <RouterLink :to="to" rel="noopener">
        <!-- <img :src="book.img" :alt="`${book.title} de ${book.author}`" class="object-contain object-top" /> -->
      </RouterLink>
    </div>
    <div class="py-2">
      <RouterLink :to="to" rel="noopener"
        ><span v-if="book.title" class="text-center font-semibold leading-3 text-lg">{{
          book.title
        }}</span></RouterLink
      >
      <div class="flex justify-between">
        <span v-if="book.author" class="text-sm">{{ book.author }}</span>
        <span class="text-base font-bold">{{ book.price ? `${book.price} €` : 'Gratuit' }}</span>
      </div>
      <span v-if="book.state" class="block">{{ book.state }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { Books } from '../interfaces/books'

const props = defineProps<{
  book: Books
  large?: boolean
  to: string
  seller?: string
  buyer?: string
  date?: Date | number | string
}>()
</script>
