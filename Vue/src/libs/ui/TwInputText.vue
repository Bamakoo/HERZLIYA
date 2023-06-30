<template>
  <label for="">
    <input :type="type ?? 'text'" v-model="text" />
  </label>
</template>

<script setup lang="ts">
import { computed } from 'vue'

const props = defineProps<{
  label?: string
  disabled?: boolean
  type?: string
  placeholder?: string
  modelValue?: string | number | null
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
