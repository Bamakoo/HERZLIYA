<template>
  <label :for="forText" :name="name" :aria-label="label">
    <div class="flex justify-between items-center">
      <span class="text-sm font-medium leading-6 text-gray-900">{{ label }}</span>
      <span
        v-if="hint"
        class="text-xs italic"
        :aria-describedby="`Le champ ${label} est obligatoire`"
        >{{ hint }}</span
      >
    </div>
    <input
      :type="type ?? 'text'"
      v-model.trim="text"
      :aria-required="required"
      :required="required"
      :aria-placeholder="placeholder"
      :placeholder="placeholder"
      :name="name"
      :aria-autocomplete="autocomplete ? 'inline' : 'none'"
      :autocomplete="autocomplete ? 'on' : 'off'"
      :aria-disabled="disabled"
      :disabled="disabled"
      :step="step"
      :min="min"
      class="block w-full rounded-md border-0 py-2 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-secondary-dark sm:text-sm sm:leading-6"
    />
  </label>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  label: string
  disabled?: boolean
  type?: string
  placeholder?: string
  modelValue?: string | number | null
  autocomplete?: boolean | string
  name?: string
  required?: boolean
  hint?: string
  forText?: string
  min?: number
  step?: number
}>()

const emit = defineEmits<{
  (event: 'update:model-value', value: string): void
}>()

const text = computed({
  get() {
    return props.modelValue?.toString() ?? ''
  },
  set(val: string) {
    emit('update:model-value', val)
  }
})
</script>
