<template>
  <div class="p-8 mx-auto max-w-7xl">
    <div class="max-w-4 text-center text-lg">
      <h1>Vente ou troc : débarassez-vous de vos livres encombrants sur Herzliya !</h1>
    </div>
    <div>
      <h2 class="text-center py-8 text-5xl font-semibold">Livres {{ genre }}</h2>

      <div class="max-w-4xl mx-auto space-y-8">
        <TwCard
          v-for="(book, index) in books"
          large
          :key="index"
          :title="book.title"
          :img="book.img"
          :author="book.author"
          :price="book.price"
          :to="book.id"
          :seller="book.seller"
          class="mx-auto"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import TwCard from '@/libs/ui/TwCard.vue'
import ImgTest from '../assets/pexels-cristian-mihaila-14537683.jpg'
const genre = 'emit de latela menu props'

const books = [
  {
    img: ImgTest,
    title: 'Mortelle Adèle',
    author: 'Mr Tan',
    price: 0,
    id: '/mortelle-adele',
    seller: 'Emmadorable'
  },
  {
    img: ImgTest,
    title: 'Les Malheurs de Sophie',
    author: 'La comtesse de Ségur',
    price: 5,
    id: '/malheurs-sophie',
    seller: 'BoohBlueTea'
  },
  {
    img: ImgTest,
    title: "Harry Potter : le prisonier d'Azkaban",
    author: 'J. K. Rowlling',
    price: 25,
    id: '/harry-potter-prisonnier-askaban',
    seller: 'SabiSab'
  },
  {
    img: ImgTest,
    title: 'Petit Poilu',
    author: 'Père Castor',
    price: 2,
    id: '/petit-poilu',
    seller: 'Tagada'
  },
  {
    img: ImgTest,
    title: 'Lulu Vroumette',
    author: 'Daniel Picouli',
    price: 30,
    id: '/lulu-vroumette',
    seller: 'Chacha'
  },
  {
    img: ImgTest,
    title: 'Titeuf',
    author: 'ZEP',
    price: 12.5,
    id: '/titeuf',
    seller: 'Mymy'
  },
  {
    img: ImgTest,
    title: 'Peter Pan',
    author: 'Simon Rousseau',
    price: 4.25,
    id: '/peter-pan',
    seller: 'Quantine'
  }
]
</script>
