<template>
  <form v-if="onSubmit || onCancel" @submit.prevent="submit">
    <div class="space-y-2 text-center mb-10">
      <h1 v-if="title" class="text-4xl font-semibold">{{ title }}</h1>
      <span v-if="description" class="text-base text-gray-400">{{ description }}</span>
    </div>
    <div class="space-y-12">
      <slot></slot>
    </div>

    <div v-if="onSubmit || onCancel" class="mt-6 flex items-center justify-end gap-x-6">
      <TwButton type="button" color="bg-gray-500" @click="cancel">Annuler</TwButton>
      <TwButton type="submit">{{ submitText }}</TwButton>
    </div>
  </form>
  <div v-else class="p-4">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { TwButton } from './index.vue'

const props = defineProps<{
  title?: string
  description?: string
  submitText: string
  onSubmit?: () => Promise<unknown>
  onCancel?: () => Promise<unknown> | unknown
}>()

const isLoading = ref(false)
const isDisabled = ref(false)

const submit = async () => {
  if (!props.onSubmit) return
  try {
    isLoading.value = true
    isDisabled.value = true
    await props.onSubmit()
  } catch (err) {
    throw new Error(`${(err as Error).message}`)
  } finally {
    isLoading.value = false
    isDisabled.value = false
  }
}
const cancel = async () => {
  if (!props.onCancel) return
  try {
    isDisabled.value = true
    await props.onCancel()
  } catch (error) {
    throw new Error(`${(error as Error).message}`)
  } finally {
    isDisabled.value = false
  }
}
</script>
