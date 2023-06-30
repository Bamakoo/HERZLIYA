<template>
  <div class="mx-auto max-w-3xl my-20 p-4">
    <h1 class="mb-10 text-4xl text-center font-semibold">Créer mon compte</h1>
    <TwForm actionText="Créer mon compte" :onSubmit="onSubmit">
      <div class="border-b border-gray-900/10 pb-12">
        <div class="mt-10 grid gap-x-6 gap-y-8 sm:grid-cols-6">
          <div class="sm:col-span-3">
            <label for="title" class="block text-sm font-medium leading-6 text-gray-900"
              >Nom utilisateur
              <div class="mt-2">
                <input
                  v-model.trim="datas.username"
                  type="text"
                  name="title"
                  autocomplete="on"
                  required
                  class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                />
                <!-- <InputText v-model="datas?.username" label="Nom utilisateur" /> -->
              </div>
            </label>
          </div>

          <div class="sm:col-span-3">
            <label for="author" class="block text-sm font-medium leading-6 text-gray-900"
              >E-mail</label
            >
            <div class="mt-2">
              <input
                v-model.trim="datas.email"
                type="text"
                name="author"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label for="country" class="block text-sm font-medium leading-6 text-gray-900"
              >Pays</label
            >
            <div class="mt-2">
              <input
                v-model.trim="datas.country"
                type="text"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
            <label for="city" class="block text-sm font-medium leading-6 text-gray-900"
              >Ville</label
            >
            <div class="mt-2">
              <input
                v-model.trim="datas.city"
                name="city"
                type="text"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label for="author" class="block text-sm font-medium leading-6 text-gray-900"
              >Livre préféré
              <div class="mt-2">
                <input
                  v-model.trim="datas.favoriteBook"
                  type="text"
                  name="author"
                  autocomplete="on"
                  required
                  class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                />
              </div>
            </label>
          </div>
        </div>
        <div class="sm:col-span-3">
          <label for="author" class="block text-sm font-medium leading-6 text-gray-900"
            >Auteurice préféré
            <div class="mt-2">
              <input
                v-model.trim="datas.favoriteAuthor"
                type="text"
                name="author"
                autocomplete="on"
                required
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </label>
        </div>
      </div>
    </TwForm>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import { TwForm } from '@/libs/ui/index.vue'
import { fetchUsers } from '@/api/axios/users.routes'
import type { Users } from '@/libs/interfaces/users'
// import InputText from '@/libs/ui/InputText.vue'

type User = Omit<Users, 'id' | 'updatedAt'>
// const datas = ref<User>()
const datas = ref<{
  username: string | null
  email: string | null
  city: string | null
  country: string | null
  favoriteAuthor: string | null
  favoriteBook: string | null
}>({
  username: null,
  email: null,
  city: null,
  country: null,
  favoriteAuthor: null,
  favoriteBook: null
})
const { create } = await fetchUsers()
const onSubmit = async () => {
  try {
    if (!datas.value) return
    const newUser: User = {
      username: datas.value?.username ?? null,
      email: datas.value?.email ?? null,
      city: datas.value?.city ?? null,
      country: datas.value?.country ?? null,
      favoriteAuthor: datas.value?.favoriteAuthor ?? null,
      favoriteBook: datas.value?.favoriteBook ?? null,
      createdAt: new Date(Date.now())
    }
    console.log(newUser)
    const newAccount = create(newUser)
    return newAccount
  } catch (error) {
    console.error((error as Error).message)
    return error
  }
}
</script>
