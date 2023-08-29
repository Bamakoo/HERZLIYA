<template>
  <div class="mx-auto max-w-7xl">
    <div v-for="(item, index) in cart.books" :key="index" class="grid grid-cols-2">
      <div>
        <div>{{ item.title }}</div>
        <div>{{ item.author }}</div>
      </div>
      <div>
        <div>{{ item.state }}</div>
        <div>{{ item.price }}</div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useCartStore } from '@/stores/useCartStore'
import { useAccountStore } from '@/stores/useAccountStore'

const accountStore = useAccountStore()
const cartStore = useCartStore()
const userId = (await accountStore.userList)[0].id
const cart = await cartStore.retrieveCart(userId)
</script>
