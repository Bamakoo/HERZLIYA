<template>
  <AccountDetails v-if="selectedUser" :id="selectedUser" />

  <div v-else>
    <h1>Toustes les utilisateurices</h1>
    <div class="gap-4 grid grid-cols-3">
      <div
        v-for="(user, index) in users"
        :key="index"
        class="bg-white rounded border max-w-md border-gray-300 cursor-pointer p-2"
        @click="goTo(user.id)"
      >
        <div class="flex justify-between">
          <div>
            <div class="text-lg font-semibold">{{ user.username }}</div>
            <div class="text-sm font-medium">Livres à vendre : {{ user.books.length }}</div>
          </div>
          <div class="text-right">
            <div>{{ user.city }}</div>
            <div class="font-semibold">{{ user.country }}</div>
          </div>
        </div>
      </div>
    </div>
    <!-- {{ user }} -->
  </div>
</template>

<script setup lang="ts">
import { onBeforeMount, ref } from 'vue'
import { useFetchAccounts } from '@/api/fetchs/useFetchAccounts'
import router from '@/router'
import AccountDetails from './AccountDetails.vue'

const { list } = useFetchAccounts()
const users = await list()
onBeforeMount(() => users)

const selectedUser = ref('')

const goTo = (user_id: string) => (selectedUser.value = user_id) //router.push(`/account/${user_id}`)
</script>
