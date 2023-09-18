<template>
  <button
    role="button"
    aria-roledescription="Bouton pour aimer"
    class="flex flex-col items-center"
    @click="like"
  >
    <HeartIcon :class="['h-7 w-7', { 'text-red-600 ': liked }]" />
    <span class="text-xs">J'aime</span>
  </button>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { HeartIcon } from '@heroicons/vue/24/solid'
import { useAccountStore } from '@/stores/useAccountStore'
const accountStore = useAccountStore()
// const bookId =
// accountStore.userAccount.likes = bookId
const liked = ref(false)
const like = () => {
  liked.value = !liked.value
  //POST DANS TABLE LIKES (USER -> LIKES) => USER TOKEN + BOOK ID
}
</script>
