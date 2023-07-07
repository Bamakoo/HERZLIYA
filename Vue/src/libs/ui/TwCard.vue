<template>
  <RouterLink v-if="large" :to="to">
    <div class="flex wax-w-2xl rounded-md overflow-hidden bg-white max-w-2xl h-28 border">
      <div class="aspect-w-1 aspect-h-1 w-1/3">
        <img :src="img" :alt="`${title}`" class="object-contain object-top shrink-0" />
      </div>
      <div class="p-2 w-full">
        <span class="text-lg font-bold block">{{ title }}</span>
        <div class="flex justify-between">
          <span class="text-sm">{{ author }}</span>
          <span class="text-base font-bold">{{ price ? `${price} €` : 'Gratuit' }}</span>
        </div>
      </div>
    </div>
  </RouterLink>

  <RouterLink v-else :to="to" el="noopener">
    <div class="bg rounded-lg max-w-sm p-3 bg-white border">
      <div class="aspect-w-3 rounded-md overflow-hidden aspect-h-1 w-full">
        <img :src="img" :alt="`${title} de ${author}`" class="object-contain object-top" />
      </div>
      <div class="py-2">
        <span v-if="title" class="text-center font-semibold leading-3 text-lg">{{ title }}</span>
        <div class="flex justify-between">
          <span v-if="author" class="text-sm">{{ author }}</span>
          <span class="text-base font-bold">{{ price ? `${price} €` : 'Gratuit' }}</span>
        </div>
        <span v-if="state" class="block">{{ state }}</span>
      </div>
    </div>
  </RouterLink>
</template>

<script setup lang="ts">
const props = defineProps<{
  large?: boolean
  title: string
  author?: string
  price?: number
  img: string
  state?:
    | 'horrendous'
    | 'bad'
    | 'okay'
    | 'passable'
    | 'acceptable'
    | 'good'
    | 'excellent'
    | 'brandNew'
  to: string
}>()
</script>
