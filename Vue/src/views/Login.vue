<template>
  <div class="mx-auto max-w-lg p-4">
    <form class="bg-secondary-light/20 p-4 md:p-6 lg:p-8 rounded-xl" @submit.prevent="login">
      <h1 class="text-4xl font-semibold text-center mb-10">Me connnecter</h1>
      <div class="space-y-8 border-b pb-4 border-gray-200">
        <TwInputText
          v-model="datas.username"
          label="Nom utilisateur"
          autocomplete
          required
          class="mb-4"
        />
        <TwInputText
          type="password"
          v-model="datas.password"
          label="Mot de passe"
          autocomplete
          required
        />
        <TwButton
          type="submit"
          size="l"
          class="bg-secondary font-semibold justify-center"
          :loading="isLoading"
          >Me connecter</TwButton
        >
      </div>
      <div class="space-y-2 pt-4 max-w-xl mx-auto">
        <span class="font-semibold block text-sm text-center">Pas encore de compte ?</span>
        <TwButton href="/signup" size="l" color="gray" class="justify-center"
          >Créer mon compte</TwButton
        >
      </div>
    </form>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import { TwInputText, TwButton } from '@/libs/ui/index.vue'
import { useAccountStore } from '@/stores/useAccountStore'
import httpClient from '@/api/httpClient'
import router from '@/router'
import type { Users } from '@/libs/interfaces/users'

const datas = ref<{
  username: Users['username']
  password: Users['password']
}>({
  username: null,
  password: null
})

const isLoading = ref(false)

const login = async () => {
  try {
    if (!datas.value.username && !datas.value.password) return
    isLoading.value = true

    const { data } = await httpClient.post('/login', null, {
      auth: { username: datas.value.username, password: datas.value.password }
    })

    const accountStore = useAccountStore()
    accountStore.token = data.value

    window.localStorage.setItem('token', data)

    if (data && router.currentRoute.value.fullPath !== '/login') router.go(-1)
    router.replace('/')
  } catch (error) {
    console.error((error as Error).message)
  } finally {
    isLoading.value = false
  }
}
</script>
