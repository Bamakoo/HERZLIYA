<template>
  <div class="max-w-7xl mx-auto p-8 space-y-28 flex">
    <div class="flex flex-col items-center space-y-4">
      <!-- <div class="aspect-w-1 aspect-h-1 rounded-full">
        <img :src="user.img" :alt="user.username" class="object-cover object-top" />
      </div> -->
      <h1 class="text-3xl font-bold mb-6">{{ user.username }}</h1>
      <div class="space-x-2">
        <span>{{ user.city }}, {{ user.country }}</span>
      </div>
      <div>
        <span>Membre depuis : {{ memberSince }}</span>
      </div>
      <div class="flex items-center">
        Note :
        <StarIcon v-for="star in 5" :key="star" class="text-yellow-600 w-5 h-5 inline" />
      </div>
      <div>
        <span>Livre préféré : {{ user.favoriteBook }}</span>
      </div>
      <div>
        <span>Auteur préféré : {{ user.favoriteAuthor }}</span>
      </div>
      <TwButton size="l" class="mt-8" @click="addFriend"
        ><UserPlusIcon class="h-5 w-5 text-white mr-2 stroke-2" /><span
          >Ajouter en ami</span
        ></TwButton
      >
    </div>
    <div class="grid gap-y-4 lg:grid-cols-3 lg:gap-4 mt-8">
      <div
        v-for="(book, index) in user.books"
        :key="index"
        class="rounded max-w-lg bg-white border border-gray-300"
      >
        <div>
          <span class="block">{{ book.title }}</span>
          <span class="block uppercase">{{ book.author }}</span>
        </div>
        <div>
          <span class="block">{{ book.state }}</span>
          <span class="block">{{ book.price }}</span>
        </div>
      </div>
    </div>
  </div>
  <TwButton color="red" @click="logout" class="absolute right-0">Bye Bye</TwButton>
</template>

<!-- <script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { useRoute } from 'vue-router'
import { useAccountStore } from '@/stores/useAccountStore'
import { TwButton } from '@/libs/ui/index.vue'
import type { Users } from '@/libs/interfaces/users'

const route = useRoute()
const { id } = route.params
const accountStore = useAccountStore()

const user = ref<Users>()
onBeforeMount(async () => (user.value = await accountStore.retrieveUserAccount(id as string)))
const logout = () => console.log('bye bye !')
</script> -->

<script setup lang="ts">
import { useAccountStore } from '@/stores/useAccountStore'
import type { Users } from '@/libs/interfaces/users'
import { StarIcon } from '@heroicons/vue/24/solid'
import { UserPlusIcon } from '@heroicons/vue/24/outline'
import { TwButton } from '@/libs/ui/index.vue'
import router from '@/router'
import axios from 'axios'
import { useFetchFriends } from '@/api/fetchs/useFetchFriends'
// import { useRoute } from 'vue-router';

const props = defineProps<{ id: Users['id'] }>()

const accountStore = useAccountStore()
const user = await accountStore.fetchUserData(props.id)
const { createdAt } = user
const memberSince = new Date(createdAt).toLocaleDateString('fr-FR')
const fetchFriends = useFetchFriends()

const route = router

const logout = () => {
  axios.defaults.headers.delete.Authorization
  window.localStorage.removeItem('token')
  route.go(0)
}

const addFriend = async () => {
  const data = await fetchFriends.create(props.id)
  const friends = accountStore.account?.friends
  friends?.push(data)
  console.log(friends)
  return data
}

// VÉRIFIER QUE C'EST PAS MOI => DIFFÉRENCE DE TOKEN + AFFICHER LE BOUTON QUE SI LES TOKEN SONT DIFFÉRENTS
// PB CORS : Access to XMLHttpRequest at 'http://127.0.0.1:3000/friends' from origin 'http://localhost:5173' has been blocked by CORS policy: No 'Access-Control-Allow-Origin' header is present on the requested resource.
// TO DO : CRÉER LA ROUT EN BACK POUR VOIR SI ÇA FONCTIONNE
</script>
