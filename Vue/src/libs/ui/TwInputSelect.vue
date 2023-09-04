<template>
  <label :for="forText">
    <div class="flex justify-between items-center">
      <span class="text-sm font-medium leading-6 text-gray-900">{{ label }}</span>
      <span
        v-if="hint"
        class="text-xs italic"
        :aria-describedby="`Le champ ${label} est obligatoire`"
        >{{ hint }}</span
      >
    </div>

    <div>
      <select
        v-model="selected"
        :name="name"
        :aria-required="required"
        :required="required"
        :aria-disabled="disabled"
        :disabled="disabled"
        class="block w-full rounded-md border-0 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-secondary-dark sm:max-w-xs sm:text-sm sm:leading-6 px-2"
      >
        <option v-for="(option, index) in options" :key="index" :value="option.value">
          {{ option.name }}
        </option>
      </select>
    </div>
  </label>
  <span class="text-xs">{{ subhint }}</span>
</template>
<script setup lang="ts">
import { computed } from 'vue'
const props = defineProps<{
  options: { name: string; value: string }[]
  modelValue?: string
  label: string
  hint?: string
  subhint?: string
  forText?: string
  name?: string
  required?: boolean
  disabled?: boolean
}>()
const emit = defineEmits<{
  (event: 'update:model-value', value: string): void
}>()

const selected = computed({
  get() {
    return props.modelValue?.toString() ?? ''
  },
  set(val: string) {
    emit('update:model-value', val)
  }
})

console.log(selected.value)
</script>
