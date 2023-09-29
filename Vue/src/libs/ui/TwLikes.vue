<template>
  <button
    role="button"
    aria-roledescription="Bouton pour aimer"
    class="flex flex-col items-center"
    @click="(liked = !liked) && onSubmit"
  >
    <HeartIcon :class="['h-7 w-7', { 'text-red-600 ': liked }]" />
    <span class="text-xs">J'aime</span>
  </button>
</template>

<script setup lang="ts">
const props = defineProps<{ onSubmit: () => void }>()
import { ref } from 'vue'
import { HeartIcon } from '@heroicons/vue/24/solid'
const liked = ref(false)
</script>
