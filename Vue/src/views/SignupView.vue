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
      <div class="space-y-2 pt-4 max-w-xl mx-auto">
        <span class="font-semibold block text-sm">Déjà un compte ?</span>
        <TwButton href="/login" class="bg-gray-400">Connectez-vous</TwButton>
      </div>
    </TwForm>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import { TwForm, TwInputText, TwButton } from '@/libs/ui/index.vue'
import { useAccountStore } from '@/stores/useAccountStore'
import type { Users } from '@/libs/interfaces/users'
import httpClient from '@/api/httpClient'

type User = Omit<Users, 'id' | 'books' | 'cart' | 'sales' | 'friends' | 'token' | 'purchases'>

const fetchAccounts = useFetchAccounts()
const accountStore = useAccountStore()
const isLoading = ref(false)
// const isLogged = await accountStore.userList
// const token = await accountStore.retrieveUserAccount()
// isLogged.find(user => user.token === )
const datas = ref<User>({
  username: null,
  email: null,
  city: null,
  country: null,
  favoriteAuthor: null,
  favoriteBook: null,
  password: null,
  confirmPassword: null,
  createdAt: null,
  updatedAt: null
})
const onSubmit = async () => {
  try {
    if (!datas.value) return

    isLoading.value = true
    //router.go(0)
    const newUser: User = {
      username: datas.value.username ?? null,
      email: datas.value.email ?? null,
      city: datas.value.city ?? null,
      country: datas.value.country ?? null,
      favoriteAuthor: datas.value.favoriteAuthor ?? null,
      favoriteBook: datas.value.favoriteBook ?? null,
      password: datas.value.password ?? null,
      confirmPassword: datas.value.confirmPassword ?? null,
      createdAt: new Date(Date.now()).getTime(),
      updatedAt: null
    }
    console.log(newUser)
    const newAccount = fetchAccounts.create(newUser)

    const credentials = Math.random().toString(36)
    const loginCredentials = btoa(credentials)

    accountStore.token = loginCredentials
    window.localStorage.setItem('token', accountStore.token)
    const signup = httpClient.post('/users', newUser, {
      headers: { Authorization: `Basic ${loginCredentials}` }
    })
    return [newAccount, signup]
  } catch (error) {
    console.error((error as Error).message)
    return error
  } finally {
    isLoading.value = false
  }
}
</script>
