<template>
  <div>
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
            <div class="text-lg font-semibold">{{ user }}</div>
            <div class="text-sm font-medium uppercase">{{ user.email }}</div>
          </div>
          <div class="text-right">
            <div>{{ user.city }}</div>
            <div class="font-semibold">{{ user.country }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onBeforeMount } from 'vue'
import { useAccountStore } from '@/stores/useAccountStore'
import router from '@/router'

const userStore = useAccountStore()
const users = await userStore.userList
onBeforeMount(() => users)

const goTo = (user_id: string) => router.push(`/account/${user_id}`)
</script>
