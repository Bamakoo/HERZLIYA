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
  <RouterLink
    v-if="href"
    :to="href"
    class="relative inline-flex items-center justify-center rounded-md text-sm font-semibold text-center shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"
    :class="[btnSize, btnColor]"
    ><slot></slot
  ></RouterLink>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { TwSpinner } from '@/libs/ui/index.vue'
import { RouterLink } from 'vue-router'
const props = defineProps<{
  type?: 'submit' | 'reset' | 'button'
  size?: 's' | 'm' | 'l'
  disabled?: boolean
  loading?: boolean
  href?: string
  color?: string // TO DO : define colors in DS + SG
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
    if (isDisabled.value) classes.push('bg-secondary text-white pointer-events-none focus-none')
    if (props.loading) {
      isDisabled.value
      classes.push('bg-secondary-light text-white')
    }
    classes.push(
      'bg-secondary hover:bg-secondary-medium focus-visible:outline-secondary text-white'
    )
  } else if (props.color) {
    if (isDisabled.value) classes.push('bg-secondary text-white pointer-events-none focus-none')
    if (props.loading) {
      isDisabled.value
      classes.push('bg-secondary-light text-white')
      if (props.color === 'red') {
        if (isDisabled.value) classes.push('bg-red-300 text-white pointer-events-none focus-none')
        if (props.loading) {
          isDisabled.value
          classes.push('bg-red-300 text-white')
        }
        classes.push('bg-red-600 text-white hover:bg-red-700 active:bg-red-800')
      }
      // else {
      // }
    }
    classes.push(props.color, ' focus-visible:outline-secondary text-white')
  }
  // if (!props.color) {
  //   if (isDisabled.value)
  //     classes.push('bg-secondary text-indigo-300 pointer-events-none focus-none')
  //   classes.push('bg-secondary hover:bg-secondary focus-visible:outline-secondary text-white')
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
