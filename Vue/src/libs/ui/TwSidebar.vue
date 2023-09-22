<template>
  <nav
    v-bind="{ menu }"
    class="hidden lg:flex lg:flex-col w-64 first:rounded-tr-2xl border focus:border-transparent last:rounded-br-2xl"
  >
    <component
      v-for="(sub, i) in menu.submenu"
      :is="sub.attributes.tag"
      :key="i"
      :active-class="'text-primary'"
      :aria-label="sub.name"
      v-bind="sub.attributes"
      class="focus-within:ring focus:ring-offset-0 focus-within:ring-primary hover:text-primary p-2 items-center space-x-2 focus:border-none flex"
    >
      <component v-if="sub.icon" :is="sub.icon" class="mr-2 aspect-square w-7" />
      <span class="font-semibold text-lg">{{ sub.name }}</span>
    </component>
  </nav>
</template>

<script setup lang="ts">
import type { FunctionalComponent } from 'vue'

const props = defineProps<{
  menu: {
    value: string
    title: string
    submenu: {
      value: string
      icon?: string | FunctionalComponent
      name: string
      attributes: { tag: string; onClick?: () => {}; to: string }
    }[]
  }
}>()
</script>
