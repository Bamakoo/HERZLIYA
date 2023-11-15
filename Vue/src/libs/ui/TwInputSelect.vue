<template>
  <label :for="forText" :aria-label="label">
    <div class="flex justify-between items-center">
      <span class="text-sm font-medium leading-6">{{ label }}</span>
      <span
        v-if="hint"
        class="text-xs italic"
        :aria-describedby="`Le champ ${label} est obligatoire`"
        >{{ hint }}</span
      >
    </div>

    <select
      v-model.trim="value"
      :name="name"
      :aria-required="required"
      :required="required"
      :aria-disabled="disabled"
      :disabled="disabled"
      class="block w-full rounded-md py-2 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-secondary sm:text-sm sm:leading-6 px-2"
      @change="$emit('change:modelValue', value)"
    >
      <option v-for="(option, index) in options" :key="index" :value="option.value">
        {{ option.name }}
      </option>
    </select>
    <span v-if="subhint" class="text-xs italic">{{ subhint }}</span>
  </label>
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
  (event: 'change:modelValue', value: string): void
}>()

const value = computed({
  get: () => {
    return props.modelValue ?? ''
  },
  set: (val: string) => {
    emit('change:modelValue', val)
  }
})
</script>
