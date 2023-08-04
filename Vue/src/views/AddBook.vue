<template>
  <div class="mx-auto max-w-3xl p-4">
    <TwForm
      :onSubmit="onSubmit"
      :onCancel="onCancel"
      submit-text="Vendre mon livre"
      title="Vendre un livre"
      description="Remplissez tous les champs du formulaire pour vendre votre livre."
      class="bg-secondary-light/20 p-8 rounded-xl"
    >
      <div class="border-b border-gray-900/10 pb-12">
        <span class="text-red-500 font-semibold">Tous les champs sont obligatoires</span>
        <div class="mt-10 grid gap-x-6 gap-y-8 sm:grid-cols-6">
          <TwInputText
            label="Titre"
            :model-value="datas.title"
            hint="champ obligatoire"
            name="title"
            for-text="title"
            autocomplete
            required
            class="sm:col-span-3"
          />

          <TwInputText
            label="Auteurice"
            for-text="author"
            hint="champ obligatoire"
            :model-value="datas.author"
            name="author"
            autocomplete
            required
            class="sm:col-span-3"
          />

          <TwInputText
            label="Prix"
            type="number"
            :step="0.05"
            :min="0"
            for-text="price"
            hint="champ obligatoire"
            :model-value="datas.price"
            name="price"
            autocomplete
            required
            class="sm:col-span-2"
          />

          <div class="sm:col-span-2">
            <TwInputSelect
              label="Genre"
              :options="genres"
              :model-value="selectedGenre"
              name="genre"
              required
              hint="champ obligatoire"
            />
          </div>

          <div class="sm:col-span-2">
            <label for="state" class="block text-sm font-medium leading-6 text-gray-900"
              >État</label
            >
            <div>
              <select
                v-model="selectedState"
                name="state"
                required
                class="block w-full rounded-md border-0 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-secondary-dark sm:max-w-xs sm:text-sm sm:leading-6"
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
            <div>
              <textarea
                v-model.trim="datas.description"
                name="description"
                required
                rows="3"
                hint="Champ obligatoire"
                autocomplete="on"
                class="block w-full h-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-secondary-dark sm:text-sm sm:leading-6 resize-none"
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
import { TwForm, TwInputText } from '@/libs/ui/index.vue'
import { fetchBook } from '@/api/axios/books.routes'
import type { Books } from '@/libs/interfaces/books'
import TwInputSelect from '@/libs/ui/TwInputSelect.vue'

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

type NewBook = Omit<Books, 'id' | 'status' | 'updatedAt' | 'deletedAt' | 'isFavorite'>
const datas = ref<{
  title: NewBook['title']
  author: NewBook['author']
  state: NewBook['state']
  genre: NewBook['genre']
  price: NewBook['price']
  description: NewBook['description']
  img: NewBook['img']
  createdAt: NewBook['createdAt']
}>({
  title: '',
  author: '',
  state: null,
  genre: null,
  price: 0,
  description: '',
  img: '',
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
      img: datas.value.img,
      createdAt: datas.value.createdAt
    }
    console.log(newBookData)
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
