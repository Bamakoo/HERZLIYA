<template>
  <div class="mx-auto max-w-3xl my-20 p-4">
    <h1 class="mb-10 text-4xl text-center font-semibold">Ajouter un livre</h1>
    <TwForm :onSubmit="onSubmit" :onCancel="onCancel" action-text="Vendre mon livre">
      <div class="border-b border-gray-900/10 pb-12">
        <span class="text-red-500 font-semibold">Tous les champs sont obligatoires</span>
        <div class="mt-10 grid gap-x-6 gap-y-8 sm:grid-cols-6">
          <div class="sm:col-span-3">
            <label for="title" class="block text-sm font-medium leading-6 text-gray-900"
              >Titre</label
            >
            <div class="mt-2">
              <input
                v-model.trim="datas.title"
                type="text"
                name="title"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label for="author" class="block text-sm font-medium leading-6 text-gray-900"
              >Auteur-Autrice</label
            >
            <div class="mt-2">
              <input
                v-model.trim="datas.author"
                type="text"
                name="author"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label for="price" class="block text-sm font-medium leading-6 text-gray-900"
              >Prix</label
            >
            <div class="mt-2">
              <input
                v-model.number="datas.price"
                step="0.01"
                min="0"
                name="price"
                type="number"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label for="genre" class="block text-sm font-medium leading-6 text-gray-900"
              >Genre</label
            >
            <div class="mt-2">
              <select
                v-model="selectedGenre"
                name="genre"
                autocomplete="genre-name"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
              >
                <option v-for="(genre, index) in genres" :key="index" :value="genre.value">
                  {{ genre.name }}
                </option>
              </select>
            </div>
          </div>
          <div class="sm:col-span-3">
            <label for="state" class="block text-sm font-medium leading-6 text-gray-900"
              >État</label
            >
            <div class="mt-2">
              <select
                v-model="selectedState"
                name="state"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
              >
                <option v-for="(state, index) in states" :key="index" :value="state.value">
                  {{ state.name }}
                </option>
              </select>
            </div>
          </div>
          <div class="col-span-full">
            <label for="description" class="block text-sm font-medium leading-6 text-gray-900"
              >Description</label
            >
            <div class="mt-2">
              <textarea
                v-model.trim="datas.description"
                name="description"
                required
                rows="3"
                autocomplete="on"
                class="block w-full h-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 resize-none"
              />
            </div>
          </div>
        </div>
      </div>
    </TwForm>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { TwForm } from '@/libs/ui/index.vue'
import { fetchBook } from '@/api/axios/books.routes'
import type { Books } from '@/libs/interfaces/books'

const selectedGenre = ref('')
const selectedState = ref('')
const genres = [
  { value: 'fantasy', name: 'Fantaisie' },
  { value: 'scienceFiction', name: 'Science-Fiction' },
  { value: 'action', name: 'Action' },
  { value: 'mystery', name: 'Mystère' },
  { value: 'horror', name: 'Horreur' },
  { value: 'romance', name: 'Romance' },
  { value: 'realism', name: 'Non-Fiction' },
  { value: 'biography', name: 'Biographie' }
]

const states = [
  { value: 'horrendous', name: 'Horrible' },
  { value: 'bad', name: 'Mauvais' },
  { value: 'okay', name: 'Okay' },
  { value: 'passable', name: 'Passable' },
  { value: 'acceptable', name: 'Acceptable' },
  { value: 'good', name: 'Bon État' },
  { value: 'excellent', name: 'Excellent' },
  { value: 'brandNew', name: 'Neuf' }
]
type NewBook = Omit<Books, 'id' | 'status' | 'updatedAt' | 'deletedAt'>

const datas = ref<{
  title: NewBook['title']
  author: NewBook['author']
  state: NewBook['state']
  genre: NewBook['genre']
  price: NewBook['price']
  description: NewBook['description']
  createdAt: NewBook['createdAt']
}>({
  title: '',
  author: '',
  state: null,
  genre: null,
  price: 0,
  description: '',
  createdAt: new Date(Date.now())
})

const { create } = await fetchBook()
const onSubmit = async () => {
  try {
    const newBookData: NewBook = {
      title: datas.value?.title,
      author: datas.value?.author,
      state: datas.value?.state ?? null,
      genre: datas.value?.genre ?? null,
      price: datas.value?.price,
      description: datas.value?.description,
      createdAt: datas.value.createdAt
    }
    const newBook = await create(newBookData)
    return newBook
  } catch (error) {
    console.error((error as Error).message)
    return error
  }
}
const onCancel = () => {
  return
}
</script>
