<template>
  <div class="mx-auto max-w-3xl p-4">
    <TwForm
      title="Créer mon compte"
      :onSubmit="onSubmit"
      submitText="Créer mon compte"
      class="bg-secondary-light/20 p-8 rounded-xl"
    >
      <div
        class="divide-y divide-gray-200 border-b border-gray-200 pb-12 mt-10 grid gap-x-6 gap-y-12 sm:grid-cols-6"
      >
        <div class="sm:col-span-6 gap-8 grid sm:grid-cols-2">
          <TwInputText
            v-model="datas.username"
            label="Nom utilisateur"
            autocomplete
            required
            hint="Champ obligatoire"
          />

          <TwInputText
            v-model="datas.email"
            label="E-mail"
            autocomplete
            required
            hint="Champ obligatoire"
          />
          <TwInputText
            v-model="datas.password"
            label="Mot de passe"
            autocomplete
            required
            hint="Champ obligatoire"
          />
          <TwInputText
            v-model="datas.confirmPassword"
            label="Confirmer le mot de passe"
            autocomplete
            required
            hint="Champ obligatoire"
          />
        </div>
        <div class="sm:col-span-6 pt-12 gap-6 grid sm:grid-cols-2">
          <TwInputText
            v-model="datas.country"
            label="Pays"
            autocomplete
            required
            hint="Champ obligatoire"
          />
          <TwInputText
            v-model="datas.city"
            label="Ville"
            autocomplete
            required
            hint="Champ obligatoire"
          />
        </div>

        <div class="sm:col-span-6 pt-12 gap-8 grid sm:grid-cols-2">
          <TwInputText
            v-model="datas.favoriteBook"
            label="Livre préféré"
            autocomplete
            required
            hint="Champ obligatoire"
          />
          <TwInputText
            v-model="datas.favoriteAuthor"
            label="Auteurice préféré"
            autocomplete
            required
            hint="Champ obligatoire"
          />
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
import TwInputText from '@/libs/ui/TwInputText.vue'
type User = Omit<Users, 'id' | 'updatedAt' | 'books' | 'cart'>
// const datas = ref<User>()
const datas = ref<{
  username: string | null
  email: string | null
  city: string | null
  country: string | null
  favoriteAuthor: string | null
  favoriteBook: string | null
  password: string | null
  confirmPassword: string | null
}>({
  username: null,
  email: null,
  city: null,
  country: null,
  favoriteAuthor: null,
  favoriteBook: null,
  password: null,
  confirmPassword: null
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
      password: datas.value.password ?? null,
      confirmPassword: datas.value.confirmPassword ?? null,
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
