<template>
  <div class="p-8 mx-auto">
    <!-- lateral menu -->
    <div>
      <h1 class="text-center py-8">Livres {{ genre }}</h1>

      <div class="max-w-4xl mx-auto grid gap-6 lg:grid-cols-2">
        <TwCard
          v-for="(book, index) in books"
          large
          :key="index"
          :title="book.title"
          :img="book.img"
          :author="book.author"
          :price="book.price"
          :to="book.id"
          class="mx-auto"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// import lateral menu
import TwCard from '@/libs/ui/TwCard.vue'
import ImgTest from '../assets/pexels-cristian-mihaila-14537683.jpg'
const genre = 'emit de latela menu props'

const books = [
  {
    img: ImgTest,
    title: 'Mortelle Adèle',
    author: 'Mr Tan',
    price: 0,
    id: '/mortelle-adele'
  },
  {
    img: ImgTest,
    title: 'Les Malheurs de Sophie',
    author: 'La comtesse de Ségur',
    price: 5,
    id: '/malheurs-sophie'
  },
  {
    img: ImgTest,
    title: "Harry Potter : le prisonier d'Azkaban",
    author: 'J. K. Rowlling',
    price: 25,
    id: '/harry-potter-prisonnier-askaban'
  },
  {
    img: ImgTest,
    title: 'Petit Poilu',
    author: 'Père Castor',
    price: 2,
    id: '/petit-poilu'
  },
  {
    img: ImgTest,
    title: 'Lulu Vroumette',
    author: 'Daniel Picouli',
    price: 30,
    id: '/lulu-vroumette'
  },
  {
    img: ImgTest,
    title: 'Titeuf',
    author: 'ZEP',
    price: 12.5,
    id: '/titeuf'
  },
  {
    img: ImgTest,
    title: 'Peter Pan',
    author: 'Simon Rousseau',
    price: 4.25,
    id: '/peter-pan'
  }
]
</script>
