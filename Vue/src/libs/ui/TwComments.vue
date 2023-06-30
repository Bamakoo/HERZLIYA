<template>
  <div class="flex space-x-4">
    <div class="rounded-full aspect-square h-12 bg-gray-200">
      <img :src="src" :alt="name" />
    </div>
    <div class="aspect-h-3 aspect-w-9 max-w-lg rounded-md bg-gray-200 py-2 px-4">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{ src: string; name?: string }>()
</script>
