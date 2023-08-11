<template>
  <TheHeader />
  <main>
    <slot></slot>
  </main>

  <!-- footer -->
</template>

<script setup lang="ts">
import TheHeader from '@/components/TheHeader.vue'
</script>
