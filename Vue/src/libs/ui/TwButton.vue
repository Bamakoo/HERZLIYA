<template>
  <button
    ref="button"
    v-if="type"
    :type="type"
    :class="[
      'rounded-md px-3 py-2 text-sm font-semibold text-center shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2',
      btnSize,
      btnColor
    ]"
  >
    <TwSpinner v-if="loading" />
    <!-- p-2  -->
    <!-- <span v-if="icon" class="mr-2"><slot name="icon"></slot></span> -->
  </button>
  <a v-if="link" :href="link"></a>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { TwSpinner } from '@/libs/ui/index.vue'
const props = defineProps<{
  type: 'button' | 'submit' | 'reset'
  icon?: string
  size?: 's' | 'l'
  disabled?: boolean
  loading?: boolean
  link?: string
}>()

const btnSize = computed(() => {
  const classes: string[] = []
  if (!props.size) {
    classes.push('bg-indigo-600 text-white hover:bg-indigo-500 focus-visible:outline-indigo-600')
  } else {
    if (props.size === 's') {
      classes.push('px-2.5 py-1.5 text-xs font-medium leading-6')
    } else {
      classes.push('w-full text-lg px-6 py-2 inline-block')
    }
  }
  return classes
})

const btnColor = computed(() => {
  const classes: string[] = []
  if (props.disabled) {
    classes.push('bg-gray-400 text-gray-500')
  }
  if (props.loading) {
    classes.push('bg-gray-400 text-gray-600') //plus spinner
  }
  return classes
})
// if icon ??
</script>
