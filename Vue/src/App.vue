<script setup lang="ts">
import { RouterView } from 'vue-router'
import TheHeader from './components/TheHeader.vue'
import TwSidebar from './libs/ui/TwSidebar.vue'
import {
  ShieldCheckIcon,
  MagnifyingGlassCircleIcon,
  AcademicCapIcon,
  HeartIcon
} from '@heroicons/vue/24/outline'

const menus = [
  { value: 'realism', icon: ShieldCheckIcon, name: 'Non-fiction', to: '#' },
  { value: 'mystery', icon: MagnifyingGlassCircleIcon, name: 'Mystère', to: '#' },
  { value: 'fantasy', icon: AcademicCapIcon, name: 'Fantaisie', to: '#' },
  { value: 'romance', icon: HeartIcon, name: 'Romance', to: '#' },
  { value: 'scienceFiction', icon: '', name: 'Science-Fiction' },
  { value: 'action', icon: '', name: 'Action' },
  { value: 'mystery', icon: '', name: 'Mystère' },
  { value: 'horror', icon: '', name: 'Horreur' },
  { value: 'realism', icon: '', name: 'Non-Fiction' },
  { value: 'biography', icon: '', name: 'Biographie' }
]
</script>

<template>
  <RouterView v-slot="{ Component }">
    <TheHeader />
    <Suspense>
      <component :is="Component" />
    </Suspense>
    <!-- <TwSidebar
      :to="`#${menus.map((men) => men.to)}`"
      :icon="menus.map((men) => men.icon)"
      :name="menus.map((men) => men.name)"
      v-bind="{ menus }"
    > 
    </Sidebar> -->
  </RouterView>
</template>
