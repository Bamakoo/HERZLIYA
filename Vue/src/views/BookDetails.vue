<template>
  <h1>
    {{ title }}
  </h1>
</template>

<script setup lang="ts">
const title = window.URL.name
</script>