<template>
  <div class="mx-auto max-w-lg p-4">
    <form class="bg-secondary-light/20 p-8 rounded-xl">
      <h1 class="text-4xl font-semibold text-center mb-10">Me connnecter</h1>
      <div class="space-y-8 border-b pb-4 border-gray-200">
        <TwInputText
          v-model="datas.username"
          label="Nom utilisateur"
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
        <TwButton
          type="button"
          size="l"
          class="bg-secondary font-semibold justify-center"
          @click="login"
          :loading="isLoading"
          >Me connecter</TwButton
        >
      </div>
      <div class="space-y-2 pt-4 max-w-xl mx-auto">
        <span class="font-semibold block text-sm">Pas encore de compte ?</span>
        <TwButton href="/signup" color="bg-gray-400">Créer mon compte</TwButton>
      </div>
    </form>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import { TwInputText, TwButton } from '@/libs/ui/index.vue'
import router from '@/router'
import { useRoute } from 'vue-router'
import httpClient from '@/api/httpClient'
import type { Users } from '@/libs/interfaces/users'

const datas = ref<{
  username: Users['username']
  password: Users['password']
}>({
  username: null,
  password: null
})

const isLoading = ref(false)

const login = (e: SubmitEvent) => {
  e.preventDefault()
  try {
    if (!datas.value.username && !datas.value.password) return
    isLoading.value = true
    // router.go(0)
    const credentials = `${datas.value.username}:${datas.value.password}`
    const loginCredentials = btoa(credentials)
    const login = httpClient.post('/login', datas, {
      headers: { Authorization: `Basic ${loginCredentials}` }
    })
    window.localStorage.setItem('token', `Basic ${loginCredentials}`)
    return login
  } catch (error) {
    console.error((error as Error).message)
    return error
  } finally {
    isLoading.value = false
  }
}
</script>
