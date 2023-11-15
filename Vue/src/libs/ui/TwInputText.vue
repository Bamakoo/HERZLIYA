<template>
  <label :for="forText" :aria-label="label">
    <div class="flex justify-between items-center">
      <span class="text-sm font-medium leading-6" :class="{ 'text-red-500': hasError }">{{
        label
      }}</span>
      <span
        v-if="hint"
        class="text-xs italic"
        :class="{ 'text-red-500': hasError }"
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
      :minlength="minlength"
      class="block w-full rounded-md py-2 shadow-sm ring-1 ring-inset placeholder:text-gray-400 focus:ring-2 focus:ring-secondary focus-visible:ring-0 sm:text-sm sm:leading-6 px-2"
      :class="hasError ? 'ring-red-500' : 'ring-gray-300'"
    />
    <span
      v-if="subHint"
      class="text-xs italic"
      :class="{ 'text-red-500': hasError }"
      :aria-describedby="`Le champ ${label} est obligatoire`"
      >{{ subHint }}</span
    >
  </label>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'

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
  subHint?: string
  forText?: string
  min?: number
  step?: number
  minlength?: number | string
  error?: boolean
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

const hasError = ref(props.error)

// const controller = computed(() => {
//   const sqlDirectives = new RegExp('^(?!(dump|insert|select|alter)(\\s+(column|table|row)))', 'i')
//   if (sqlDirectives.exec(text.value)) hasError.value = true
//   return (hasError.value = false)
// })
</script>
