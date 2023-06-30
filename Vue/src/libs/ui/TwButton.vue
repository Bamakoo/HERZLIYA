<template>
  <button
    v-if="type"
    :type="type"
    class="relative inline-flex items-center justify-center rounded-md text-sm font-semibold text-center shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"
    :class="[btnSize, btnColor]"
  >
    <TwSpinner v-if="loading" class="absolute h-4 w-4" />
    <div class="justify-center flex select-none items-center" :class="{ invisible: loading }">
      <slot></slot>
    </div>
  </button>
  <a v-if="href" :href="href"><slot></slot></a>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { TwSpinner } from '@/libs/ui/index.vue'
const props = defineProps<{
  type?: 'button' | 'submit' | 'reset'
  size?: 's' | 'm' | 'l'
  disabled?: boolean
  loading?: boolean
  href?: string
  color?: string | string[] // TO DO : define colors in DS + SG
}>()

const isDisabled = computed(() => props.disabled || props.loading)

const btnSize = computed(() => {
  const classes: string[] = []
  if (!props.size) {
    classes.push(' px-3 py-2 ')
  } else {
    if (props.size === 's') {
      classes.push('sm:px-2.5 sm:py-1.5 sm:text-xs sm:font-medium sm:leading-6')
    } else {
      classes.push('w-full text-lg px-6 py-2 inline-block')
    }
  }
  return classes
})

const btnColor = computed(() => {
  const classes: string[] = []

  if (!props.color) {
    if (isDisabled.value)
      classes.push('bg-indigo-500 text-indigo-300 pointer-events-none focus-none')
    if (props.loading) {
      isDisabled.value
      classes.push('bg-gray-400 text-gray-100')
    }
    classes.push('bg-indigo-600 hover:bg-indigo-500 focus-visible:outline-indigo-600 text-white')
  } else if (props.color) {
    if (isDisabled.value)
      classes.push('bg-indigo-500 text-indigo-300 pointer-events-none focus-none')
    if (props.loading) {
      isDisabled.value
      classes.push('bg-gray-400 text-gray-100')
    }
    classes.push('bg-indigo-600 hover:bg-indigo-500 focus-visible:outline-indigo-600 text-white')
  }
  // if (!props.color) {
  //   if (isDisabled.value)
  //     classes.push('bg-indigo-500 text-indigo-300 pointer-events-none focus-none')
  //   classes.push('bg-indigo-600 hover:bg-indigo-500 focus-visible:outline-indigo-600 text-white')
  // }

  /** CASES
   * disabled + !color
   * disabled + color
   * loading + color
   * loading + !color
   * loading => disabled
   */
  return classes
})
</script>
