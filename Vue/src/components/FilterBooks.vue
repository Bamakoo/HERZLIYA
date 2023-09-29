<template>
  <Popover class="">
    <PopoverButton
      class="group inline-flex items-center rounded-md bg-secondary px-3 py-2 text-base font-medium text-white hover:bg-secondary-dark focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-opacity-75"
    >
      <FunnelIcon
        class="h-5 w-5 text-white transition duration-150 ease-in-out group-hover:text-opacity-80"
        aria-hidden="true"
      />
    </PopoverButton>

    <transition
      enter-active-class="transition duration-200 ease-out"
      enter-from-class="translate-y-1 opacity-0"
      enter-to-class="translate-y-0 opacity-100"
      leave-active-class="transition duration-150 ease-in"
      leave-from-class="translate-y-0 opacity-100"
      leave-to-class="translate-y-1 opacity-0"
    >
      <PopoverPanel class="absolute z-10 mt-3 w-screen max-w-xs px-4 sm:px-0">
        <div
          class="overflow-hidden rounded-lg shadow-lg ring-1 bg-white ring-secondary-light ring-opacity-5 p-2"
        >
          <button
            v-for="(genre, index) in genres"
            :key="index"
            class="flex items-center rounded-lg p-2 transition duration-150 ease-in-out hover:bg-secondary-light/30 focus:outline-none focus-visible:ring focus-visible:ring-secondary-light focus-visible:ring-opacity-50 w-full space-x-4"
            @click="emits('change', genre.value)"
          >
            <component :is="genre.icon" class="h-5 w-5" />
            <span class="font-medium text-gray-900">
              {{ genre.name }}
            </span>
          </button>
        </div>
      </PopoverPanel>
    </transition>
  </Popover>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useBookStore } from '../stores/useBookStore'

import { Popover, PopoverButton, PopoverPanel } from '@headlessui/vue'
import {
  ShieldCheckIcon,
  MagnifyingGlassCircleIcon,
  AcademicCapIcon,
  BeakerIcon,
  RocketLaunchIcon,
  BugAntIcon,
  BuildingLibraryIcon,
  HeartIcon,
  FunnelIcon
} from '@heroicons/vue/24/outline'

const genres = [
  {
    value: 'realism',
    icon: ShieldCheckIcon,
    name: 'Non-fiction'
  },
  {
    value: 'mystery',
    icon: MagnifyingGlassCircleIcon,
    name: 'Mystère'
  },
  {
    value: 'fantasy',
    icon: AcademicCapIcon,
    name: 'Fantaisie'
  },
  {
    value: 'romance',
    icon: HeartIcon,
    name: 'Romance'
  },
  {
    value: 'scienceFiction',
    icon: BeakerIcon,
    name: 'Science-Fiction'
  },
  {
    value: 'action',
    icon: RocketLaunchIcon,
    name: 'Action'
  },
  {
    value: 'horror',
    icon: BugAntIcon,
    name: 'Horreur'
  },
  {
    value: 'biography',
    icon: BuildingLibraryIcon,
    name: 'Biographie'
  }
]

const emits = defineEmits<{ (event: 'change', val: string): void }>()
</script>
