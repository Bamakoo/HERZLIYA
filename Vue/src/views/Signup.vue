<template>
  <div class="mx-auto max-w-3xl p-4">
    <form @submit.prevent="signup" class="bg-secondary-light/20 p-8 rounded-xl">
      <div class="space-y-2 text-center mb-10">
        <h1 class="text-4xl font-semibold">Créer mon compte</h1>
        <span class="text-base text-gray-400"
          >Créez votre compte pour profiter pleinenment du site !</span
        >
      </div>
      <div class="space-y-12">
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
              type="password"
              v-model="datas.password"
              label="Mot de passe"
              autocomplete
              required
              :error="passwordError"
              :sub-hint="
                passwordError
                  ? `${passwordError}`
                  : 'Le mot de passe doit avec 8 caractères minimum : 1 majuscule, 1 minuscule, 1 caractère spécial'
              "
            />
            <TwInputText
              type="password"
              v-model="datas.confirmPassword"
              :min="8"
              label="Confirmer le mot de passe"
              autocomplete
              required
              :error="passwordError"
              :sub-hint="
                passwordError
                  ? `${passwordError}`
                  : 'Le mot de passe doit avec 8 caractères minimum : 1 majuscule, 1 minuscule, 1 caractère spécial'
              "
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
        <div class="pt-4 max-w-xl mx-auto">
          <TwButton
            type="submit"
            size="l"
            class="bg-secondary font-semibold justify-center"
            :loading="isLoading"
            >Créer mon compte</TwButton
          >
        </div>
        <div class="col-span-12">
          <div class="space-y-2 pt-4 max-w-xl mx-auto">
            <span class="font-semibold block text-sm text-center">Déjà un compte ?</span>
            <TwButton href="/login" size="l" color="gray" class="justify-center"
              >Me connecter</TwButton
            >
          </div>
        </div>
      </div>
    </form>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import { TwInputText, TwButton } from '@/libs/ui/index.vue'
import router from '@/router'
import type { Users } from '@/libs/interfaces/users'

type User = Omit<Users, 'id' | 'books' | 'cart' | 'sales' | 'friends' | 'token' | 'purchases'>

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

const isLoading = ref(false)

const passwordError = ref('')

const signup = async () => {
  try {
    if (!datas.value) return
    if (datas.value.password !== datas.value.confirmPassword) {
      passwordError.value = 'Les mots de passe ne correspondent pas'
      return
    }
    const controller = new RegExp(
      '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$!_%*?&])[A-Za-z\\d@#$!_%*?&]{8,}$'
    )
    if (datas.value.password && controller.test(datas.value.password) === false) {
      passwordError.value =
        'Le mot de passe doit avec 8 caractères minimum : 1 majuscule, 1 minuscule, 1 caractère spécial et 1 chiffre'
      return
    }

    isLoading.value = true

    const { create } = useFetchAccounts()
    create(datas.value)

    router.replace('/login')
  } catch (error) {
    throw new Error((error as Error).message)
  } finally {
    isLoading.value = false
  }
}
</script>
