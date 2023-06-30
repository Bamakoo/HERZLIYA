<template>
  <div class="p-8 mx-auto">
    <!-- lateral menu -->
    <div>
      <h1 class="text-center py-8">Livres {{ genre }}</h1>

      <div class="max-w-4xl mx-auto grid gap-6 lg:grid-cols-2">
        <Card
          v-for="(book, index) in books"
          large
          :key="index"
          :title="book.title"
          :img="book.img"
          :author="book.author"
          :price="book.price"
          :link="book.link"
          class="mx-auto"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// import lateral menu
import Card from '@/libs/ui/Card.vue'
import ImgTest from '../assets/pexels-cristian-mihaila-14537683.jpg'
const genre = 'emit de latela menu props'

const books = [
  {
    img: ImgTest,
    title: 'Mortelle Adèle',
    author: 'Mr Tan',
    price: 0,
    link: '#'
  },
  {
    img: ImgTest,
    title: 'Les Malheurs de Sophie',
    author: 'La comtesse de Ségur',
    price: 5,
    link: '#'
  },
  {
    img: ImgTest,
    title: "Harry Potter : le prisonier d'Azkaban",
    author: 'J. K. Rowlling',
    price: 25,
    link: '#'
  },
  {
    img: ImgTest,
    title: 'Petit Poilu',
    author: 'Père Castor',
    price: 2,
    link: '#'
  },
  {
    img: ImgTest,
    title: 'Lulu Vroumette',
    author: 'Daniel Picouli',
    price: 30,
    link: '#'
  },
  {
    img: ImgTest,
    title: 'Titeuf',
    author: 'ZEP',
    price: 12.5,
    link: '#'
  },
  {
    img: ImgTest,
    title: 'Peter Pan',
    author: 'Simon Rousseau',
    price: 4.25,
    link: '#'
  }
]
</script>
