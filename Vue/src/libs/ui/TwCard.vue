<template>
  <div
    v-if="large"
    class="flex rounded-md overflow-hidden bg-white max-w-2xl h-28 border border-gray-200"
  >
    <div class="aspect-square w-1/3">
      <RouterLink :to="to" rel="noopener">
        <img :src="img" :alt="`${title}`" class="object-cover object-top shrink-0" />
      </RouterLink>
    </div>
    <div class="p-2 w-full">
      <RouterLink v-if="large" :to="to" rel="noopener"
        ><span class="text-lg font-bold block">{{ title }}</span></RouterLink
      >
      <div class="flex justify-between">
        <span class="text-sm">{{ author }}</span>
        <span class="text-base font-bold">{{ price ? `${price} €` : 'Gratuit' }}</span>
      </div>
    </div>
  </div>

  <div v-else class="bg rounded-lg max-w-sm p-3 bg-white border border-gray-200">
    <div class="aspect-w-3 rounded-md overflow-hidden aspect-h-1 w-full">
      <RouterLink :to="to" rel="noopener">
        <img :src="img" :alt="`${title} de ${author}`" class="object-contain object-top" />
      </RouterLink>
    </div>
    <div class="py-2">
      <RouterLink :to="to" rel="noopener"
        ><span v-if="title" class="text-center font-semibold leading-3 text-lg">{{
          title
        }}</span></RouterLink
      >
      <div class="flex justify-between">
        <span v-if="author" class="text-sm">{{ author }}</span>
        <span class="text-base font-bold">{{ price ? `${price} €` : 'Gratuit' }}</span>
      </div>
      <span v-if="state" class="block">{{ state }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  large?: boolean
  title: string
  author?: string
  price?: number
  // img: string
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
  seller?: string
  buyer?: string
  date?: Date | number | string
}>()
</script>
