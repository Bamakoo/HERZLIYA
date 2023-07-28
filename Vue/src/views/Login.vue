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
        <TwButton type="button" class="bg-secondary font-semibold justify-center" @click="login"
          >Me connecter</TwButton
        >
      </div>
      <div class="space-y-2 pt-4 max-w-xl mx-auto">
        <span class="font-semibold block text-sm">Pas encore de compte ?</span>
        <TwButton href="./Signup.vue" class="bg-gray-400">Créer mon compte</TwButton>
      </div>
    </form>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import { TwInputText, TwButton } from '@/libs/ui/index.vue'
import type { Users } from '@/libs/interfaces/users'
import router from '@/router'

type User = Omit<Users, 'id' | 'updatedAt' | 'books' | 'cart'>
// const datas = ref<User>()
const datas = ref<{
  email: string | null
  password: string | null
}>({
  email: null,
  password: null
})
const login = async (e: SubmitEvent) => {
  e.preventDefault()
  try {
    if (!datas.value) return
    const newUser: User = {
      email: datas.value?.email ?? null,
      password: datas.value.password ?? null
    }
    console.log(newUser)
    // REDIRECT TO HOME
    return newUser
  } catch (error) {
    console.error((error as Error).message)
    return error
  }
}
</script>
