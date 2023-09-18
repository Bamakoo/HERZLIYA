<template>
  <nav v-bind="{ menu }" class="hidden lg:flex lg:fixed inset-0 lg:flex-col max-w-max">
    <component
      :is="to ? 'RouterLink' : 'button'"
      v-for="(item, index) in menu"
      :to="item.to"
      :key="index"
      :active-class="'text-primary '"
      :aria-label="item.name"
      class="focus-within:ring bg-white focus:ring-offset-0 focus-within:ring-primary hover:text-primary first:rounded-tr-2xl last:rounded-br-2xl border focus:border-transparent"
    >
      <div class="p-2 items-center space-x-2 focus:ring-0 focus:border-none flex">
        <component :is="item.icon" class="mr-2 aspect-square w-7" />
        <span class="font-semibold text-lg">{{ item.name }}</span>
      </div>
    </component>
  </nav>
</template>

<script setup lang="ts">
import type { FunctionalComponent } from 'vue'

const props = defineProps<{
  menu: {
    value: string
    icon: string | FunctionalComponent
    name: string
    to: string
  }[]
}>()
</script>
