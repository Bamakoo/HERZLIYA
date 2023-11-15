<template>
  <div
    class="p-4 rounded-md border flex justify-between items-start space-x-2"
    :class="
      type === 'error'
        ? 'bg-red-50 border-red-500'
        : type === 'success'
        ? 'bg-green-50 border-green-400 '
        : type === 'info'
        ? 'bg-primary/10'
        : 'bg-yellow-50 border-yellow-300'
    "
  >
    <div class="flex space-x-2">
      <div class="w-5 h-5">
        <component
          :is="
            type === 'error'
              ? ExclamationTriangleIcon
              : type === 'success'
              ? CheckCircleIcon
              : type === 'info'
              ? InformationCircleIcon
              : ExclamationCircleIcon
          "
          class="h-5 w-5"
          :class="
            type === 'error'
              ? 'text-red-800'
              : type === 'success'
              ? 'text-green-800'
              : type === 'info'
              ? 'text-gray-800'
              : 'text-[#73430C]'
          "
        />
      </div>
      <div class="flex-col justify-start items-start">
        <span
          class="text-base block font-semibold leading-tight"
          :class="
            type === 'error'
              ? 'text-red-800'
              : type === 'success'
              ? 'text-green-800'
              : type === 'info'
              ? 'text-gray-800'
              : 'text-[#73430C]'
          "
        >
          {{ title }}
        </span>
        <div
          class="text-base"
          :class="
            type === 'error'
              ? 'text-red-700'
              : type === 'success'
              ? 'text-green-700'
              : type === 'info'
              ? 'text-gray-700'
              : 'text-yellow-700'
          "
        >
          <slot></slot>
        </div>
      </div>
    </div>
    <button v-if="closable" type="button" @click="emits('close', (isClose = true))">
      <XMarkIcon
        class="h-6 w-6"
        :class="
          type === 'error'
            ? 'text-red-700'
            : type === 'success'
            ? 'text-green-700'
            : type === 'info'
            ? 'text-gray-700'
            : 'text-yellow-700'
        "
      />
    </button>
  </div>
</template>
<script setup lang="ts">
import { ref } from 'vue'
import {
  InformationCircleIcon,
  ExclamationTriangleIcon,
  CheckCircleIcon,
  ExclamationCircleIcon,
  XMarkIcon
} from '@heroicons/vue/24/outline'

const props = defineProps<{
  type: 'info' | 'success' | 'error' | 'warning'
  title: string
  closable?: boolean
}>()

const emits = defineEmits<{ (event: 'close', val: boolean): void }>()

const isClose = ref(false)
</script>
