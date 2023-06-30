<template>
  <nav v-bind="{ menu }" class="relative inset-0 flex-col max-w-sm">
    <RouterLink
      :to="to"
      v-for="(item, index) in menu"
      :key="index"
      class="p-2 space-x-2 bg-gray-400"
    >
      <div class="mr-2 aspect-square w-12">{{ item.icon }}</div>
      <span>{{ item.name }}</span>
    </RouterLink>
  </nav>
</template>

<script setup lang="ts">
const props = defineProps<{
  icon: string
  name: string
  to: string
}>()
const menu = [{ icon: props.icon, name: props.name, to: props.to }]
</script>
