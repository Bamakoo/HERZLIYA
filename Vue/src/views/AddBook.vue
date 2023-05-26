<template>
  <div class="mx-auto max-w-3xl my-20 p-4">
    <h1 class="mb-10 text-4xl text-center font-semibold">Ajouter un livre</h1>
    <TwForm>
      <div class="border-b border-gray-900/10 pb-12">
        <div class="mt-10 grid gap-x-6 gap-y-8 sm:grid-cols-6">
          <div class="sm:col-span-3">
            <label for="title" class="block text-sm font-medium leading-6 text-gray-900"
              >Titre</label
            >
            <div class="mt-2">
              <input
                type="text"
                name="title"
                id="title"
                autocomplete="title"
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
                type="text"
                name="author"
                id="author"
                autocomplete="author"
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
                id="price"
                name="price"
                type="number"
                autocomplete="price"
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
                id="genre"
                name="genre"
                autocomplete="genre-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
              >
                <option v-for="(genre, index) in genres" :key="index">
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
                id="state"
                name="state"
                autocomplete="state-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
              >
                <option v-for="(state, index) in states" :key="index">{{ state.name }}</option>
              </select>
            </div>
          </div>
          <div class="col-span-full">
            <label for="description" class="block text-sm font-medium leading-6 text-gray-900"
              >Description</label
            >
            <div class="mt-2">
              <textarea
                id="description"
                name="description"
                rows="3"
                class="block w-full h-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6 resize-none"
              ></textarea>
            </div>
          </div>
        </div>
      </div>
      <template #actions>
        <TwButton type="button">Annuler</TwButton>
        <TwButton type="submit">Vendre un nouveau livre</TwButton>
      </template>
    </TwForm>
  </div>
</template>

<script setup lang="ts">
import { TwForm, TwButton } from '@/libs/ui/index.vue'

const genres = [
  { value: 'fantasy', name: 'Fantaisie' },
  { value: 'thriller', name: 'Thriller' },
  { value: 'fantastic', name: 'Fantastique' },
  { value: 'romance', name: 'Romance' },
  { value: 'non_fiction', name: 'Non-Fiction' },
  { value: 'children', name: 'Enfants' },
  { value: 'learning', name: 'Études' }
]

const states = [
  { value: 'new', name: 'Neuf' },
  { value: 'like_new', name: 'Comme Neuf' },
  { value: 'very_good', name: 'Très Bon État' },
  { value: 'good', name: 'Bon État' },
  { value: 'fair', name: 'Passable' }
]
</script>
