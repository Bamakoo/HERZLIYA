<template>
  <div class="mx-auto max-w-2xl p-4">
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
            v-model="datas.title"
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
            v-model="datas.author"
            name="author"
            autocomplete
            required
            class="sm:col-span-3"
          />

          <TwInputText
            label="Prix"
            type="number"
            :step="0.01"
            :min="0"
            for-text="price"
            hint="champ obligatoire"
            v-model="datas.price"
            name="price"
            autocomplete
            required
            class="sm:col-span-2"
          />

          <TwInputSelect
            label="Genre"
            :options="genres"
            v-model="selectedGenre"
            name="genre"
            for-text="genre"
            required
            hint="champ obligatoire"
            class="sm:col-span-2"
            @change:model-value="(val) => (selectedGenre = val)"
          />

          <TwInputSelect
            label="État"
            :options="states"
            :modelValue="selectedState"
            @change:modelValue="(val) => (selectedState = val)"
            required
            name="state"
            hint="Champ obligatoire"
            class-name="sm:col-span-2"
          />
          <div class="col-span-full">
            <label for="description" class="text-sm font-medium leading-6"
              >Description
              <textarea
                v-model.trim="datas.description"
                name="description"
                required
                rows="3"
                hint="Champ obligatoire"
                autocomplete="on"
                class="w-full h-full rounded-md border-0 py-1.5 px-2 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-secondary-dark sm:text-sm sm:leading-6 resize-none"
              />
            </label>
          </div>
        </div>
      </div>
    </TwForm>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { TwForm, TwInputText, TwInputSelect } from '@/libs/ui/index.vue'
import { useFetchBooks } from '@/api/fetchs/useFetchBooks'
import type { Books } from '@/libs/interfaces/books'
import router from '@/router'

const route = router

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
  { name: 'Horrible', value: 'horrendous' },
  { name: 'Mauvais', value: 'bad' },
  { name: 'Okay', value: 'okay' },
  { name: 'Passable', value: 'passable' },
  { name: 'Acceptable', value: 'acceptable' },
  { name: 'Bon État', value: 'good' },
  { name: 'Excellent', value: 'excellent' },
  { name: 'Neuf', value: 'brandNew' }
]

type NewBook = Omit<Books, 'id' | 'status' | 'updatedAt' | 'deletedAt' | 'isFavorite'>
const datas = ref<{
  title: NewBook['title']
  author: NewBook['author']
  state: NewBook['state']
  genre: NewBook['genre']
  price: NewBook['price']
  description: NewBook['description']
  status: NewBook['status']
  // img: NewBook['img']
  createdAt: NewBook['createdAt']
}>({
  title: null,
  author: null,
  state: null,
  price: 0,
  genre: null,
  description: undefined,
  createdAt: new Date(Date.now()).getTime(),
  status: 'available'
})

const { create } = useFetchBooks()
const onSubmit = async () => {
  try {
    const newBookData: Omit<Books, 'id'> = {
      title: datas.value?.title,
      author: datas.value?.author,
      state: selectedState.value,
      genre: selectedGenre.value,
      price: datas.value?.price,
      description: datas.value?.description,
      // img: datas.value.img,
      status: 'available',
      createdAt: datas.value.createdAt,
      updatedAt: null,
      deletedAt: null
    }
    console.log('newBookData', newBookData)
    const newBook = await create(newBookData)
    console.log('newBook', newBook)

    return newBook
  } catch (error) {
    console.error((error as Error).message)
    return error
  }
}
const onCancel = () => {
  route.back()
}
</script>
