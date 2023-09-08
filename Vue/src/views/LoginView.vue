<template>
  <div class="mx-auto max-w-lg p-4">
    <form class="bg-secondary-light/20 p-8 rounded-xl">
      <h1 class="text-4xl font-semibold text-center mb-10">Me connnecter</h1>
      <div class="space-y-8 border-b pb-4 border-gray-200">
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
import { useAccountStore } from '@/stores/useAccountStore'
import type { Users } from '@/libs/interfaces/users'
import router from '@/router'
import { useRoute } from 'vue-router'

const datas = ref<{
  email: Users['email']
  password: Users['password']
}>({
  email: null,
  password: null
})

const isLoading = ref(false)
const accountStore = useAccountStore()
const userList = await accountStore.userList

const login = (e: SubmitEvent) => {
  e.preventDefault()
  try {
    if (!datas.value.email && !datas.value.password) return
    const user = userList.find((user) => {
      if (datas.value.email === user.email && datas.value.password === user.password) {
        user.token = accountStore.userAccount?.token ?? 'nope'
        console.log(user.token)
        return user.token
      }
    })
    isLoading.value = true
    // router.go(0)
    return user
  } catch (error) {
    console.error((error as Error).message)
    return error
  } finally {
    isLoading.value = false
  }
}
</script>
