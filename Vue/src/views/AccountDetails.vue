<template>
  <div class="max-w-7xl mx-auto p-8 space-y-4">
    <div class="aspect-w-1 aspect-h-1 rounded-full">
      <img src="" alt="" class="object-cover object-top" />
    </div>
    <div>
      <div>{{ user?.username }}</div>
      <span>{{ user?.city }}</span>
      <span>{{ user?.country }}</span>
    </div>
    <div class="grid grid-cols-3 gap-4">
      <div
        v-for="(book, index) in user?.books"
        :key="index"
        class="rounded max-w-lg bg-white border border-gray-300"
      >
        <div>
          <span>{{ book.title }}</span>
          <span>{{ book.author }}</span>
        </div>
        <div>
          <span>{{ book.state }}</span>
          <span>{{ book.price }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
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
</script>
