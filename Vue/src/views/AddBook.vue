<template>
  <div class="mx-auto max-w-2xl p-4">
    <form class="bg-secondary-light/20 p-8 rounded-xl" @submit.prevent="createBook">
      <div class="space-y-2 text-center mb-10">
        <h1 class="text-4xl font-semibold">Vendez votre livre</h1>
        <span class="text-base text-gray-400"
          >Remplissez tous les champs du formulaire pour vendre votre livre.</span
        >
      </div>
      <div class="space-y-12">
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
      </div>

      <div class="mt-6 flex items-center justify-end gap-x-6">
        <TwButton type="button" color="bg-gray-500" @click="onCancel">Annuler</TwButton>
        <TwButton type="submit">Vendez votre livre</TwButton>
      </div>
    </form>

    <!-- <form
      @submit.prevent="createBook"
      submit-text="Vendre mon livre"
      title="Vendre un livre"
      description="Remplissez tous les champs du formulaire pour vendre votre livre."
      class="bg-secondary-light/20 p-8 rounded-xl"
    >
    
    </form> -->
    <!-- <TwForm
      :on-submit="createBook"
      :on-cancel="onCancel"
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
    </TwForm> -->
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { TwForm, TwInputText, TwInputSelect, TwButton } from '@/libs/ui/index.vue'
// import { useFetchBooks } from '@/api/fetchs/useFetchBooks'
import type { Books } from '@/libs/interfaces/books'
import router from '@/router'
// import { useAccountStore } from '@/stores/useAccountStore'
import httpClient from '@/api/httpClient'

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

// const accountStore = useAccountStore()

type NewBook = Omit<Books, 'id' | 'updatedAt' | 'deletedAt' | 'isFavorite'>
const datas = ref<{
  title: NewBook['title']
  author: NewBook['author']
  description: NewBook['description']
  genre: NewBook['genre']
  state: NewBook['state']
  price: NewBook['price']
  status: NewBook['status']
  sellerId: string
  buyerId: string | null
}>({
  title: null,
  author: null,
  description: undefined,
  genre: null,
  state: null,
  price: 0,
  status: 'available',
  sellerId: 'b5ZvjMmJQNbgzcCahIm6uA==',
  buyerId: null
})

// const { create } = useFetchBooks()
const createBook = async () => {
  try {
    const newBookData: Omit<Books, 'id'> = {
      title: datas.value?.title,
      author: datas.value?.author,
      description: datas.value?.description,
      genre: selectedGenre.value,
      state: selectedState.value,
      price: datas.value?.price,
      status: 'available',
      sellerId: 'b5ZvjMmJQNbgzcCahIm6uA==',
      buyerId: null
    }
    console.log('newBookData', newBookData)
    const { data } = await httpClient.post<Books>('/books', newBookData, {
      headers: { Authorization: `Bearer b5ZvjMmJQNbgzcCahIm6uA==` }
    })
    console.log('newBook', data)
    route.replace('/')
    return data
  } catch (error) {
    console.error((error as Error).message)
    return error
  }
}
const onCancel = () => {
  route.back()
}
</script>
